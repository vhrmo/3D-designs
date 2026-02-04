"""
Generate index.json with a list of all .gcode files in the directory and subdirectories.
Greps each file for comments starting with ";" and tries to identify:
- nozzle size
- temperature used (extruder and bed)
- print time
- material length / weight
- layer height
- material (PLA/PETG/ABS/... if present)

Usage:
    from tools.index_gen import generate_index
    generate_index("/path/to/root_or_gcode_folder")
This will create an index.json file in the provided folder.
"""

from __future__ import annotations

import json
import os
import re
import time
from typing import Dict, List, Optional


# --- Parsing helpers ---
_time_hms_re = re.compile(r"(?:(\d+)\s*h)?\s*(?:(\d+)\s*m)?\s*(?:(\d+)\s*s)?", re.I)


def _parse_time_to_seconds(s: str) -> Optional[int]:
    s = s.strip()
    if not s:
        return None
    # Common formats:
    # - 5033 (seconds)
    # - 1h48m
    # - 1h 48m 22s
    # - 2h
    # - 48m
    # - 01:23:45 or 23:59
    if s.isdigit():
        try:
            return int(s)
        except ValueError:
            return None
    if ":" in s:
        parts = s.split(":")
        try:
            parts = [int(p) for p in parts]
        except ValueError:
            parts = []
        if len(parts) == 3:
            h, m, sec = parts
            return h * 3600 + m * 60 + sec
        if len(parts) == 2:
            m, sec = parts
            return m * 60 + sec
    m = _time_hms_re.fullmatch(s.replace(" ", ""))
    if m:
        h = int(m.group(1) or 0)
        mi = int(m.group(2) or 0)
        se = int(m.group(3) or 0)
        return h * 3600 + mi * 60 + se
    return None


def _parse_header_metadata(lines: List[str]) -> Dict[str, Optional[float]]:
    meta: Dict[str, Optional[float]] = {
        "time_seconds": None,
        "filament_used_m": None,
        "filament_used_g": None,
        "layer_height_mm": None,
        "nozzle_mm": None,
        "temp_nozzle_C": None,
        "temp_bed_C": None,
    }

    # Patterns across slicers
    for ln in lines:
        l = ln.strip()
        if not l.startswith(";"):
            # stop early once gcode proper starts (first non-comment)
            break
        l_nosemi = l[1:].strip()

        # Cura style time
        m = re.search(r";\s*TIME\s*:\s*(\d+)", l, re.I)
        if m and meta["time_seconds"] is None:
            meta["time_seconds"] = int(m.group(1))
            continue

        # PrusaSlicer time phrases, e.g. "; estimated printing time (normal mode) = 1h 48m"
        m = re.search(r"estimated printing time[^=]*=\s*([^;]+)$", l_nosemi, re.I)
        if m and meta["time_seconds"] is None:
            secs = _parse_time_to_seconds(m.group(1).strip())
            if secs is not None:
                meta["time_seconds"] = secs
                continue

        # Filament used: Cura style: ";Filament used: 8.81m" or with weight
        m = re.search(r";\s*Filament used:\s*([0-9]*\.?[0-9]+)\s*m(?:\s+([0-9]*\.?[0-9]+)\s*g)?", l, re.I)
        if m:
            meta["filament_used_m"] = float(m.group(1))
            if m.group(2):
                meta["filament_used_g"] = float(m.group(2))
            continue

        # PrusaSlicer: "; filament used [mm] = 12345.6"
        m = re.search(r";\s*filament used \[mm\]\s*=\s*([0-9]*\.?[0-9]+)", l, re.I)
        if m:
            try:
                meta["filament_used_m"] = float(m.group(1)) / 1000.0
            except ValueError:
                pass
            continue
        m = re.search(r";\s*filament used \[g\]\s*=\s*([0-9]*\.?[0-9]+)", l, re.I)
        if m:
            try:
                meta["filament_used_g"] = float(m.group(1))
            except ValueError:
                pass
            continue

        # Layer height
        m = re.search(r";\s*Layer height\s*:\s*([0-9]*\.?[0-9]+)", l, re.I)
        if m and meta["layer_height_mm"] is None:
            try:
                meta["layer_height_mm"] = float(m.group(1))
            except ValueError:
                pass
            continue

        # Nozzle temperature from G/M codes
        # M104/M109 S{temp} (nozzle)
        m = re.search(r"M10[49]\s+S([0-9]+)", l, re.I)
        if m and meta["temp_nozzle_C"] is None:
            meta["temp_nozzle_C"] = float(m.group(1))
            continue
        # Bed temperature: M140/M190 S{temp}
        m = re.search(r"M1(40|90)\s+S([0-9]+)", l, re.I)
        if m and meta["temp_bed_C"] is None:
            meta["temp_bed_C"] = float(m.group(2))
            continue

    return meta


def _parse_from_filename(filename: str) -> Dict[str, Optional[float]]:
    name_only = os.path.splitext(os.path.basename(filename))[0]
    out: Dict[str, Optional[float]] = {
        "nozzle_mm": None,
        "layer_height_mm": None,
        "temp_nozzle_C": None,
        "material": None,
        "time_seconds": None,
    }

    # nozzleX or nozzle0.4mm
    m = re.search(r"nozzle\s*([0-9]*\.?[0-9]+)\s*mm?", name_only, re.I)
    if not m:
        m = re.search(r"nozzle\s*([0-9]*\.?[0-9]+)", name_only, re.I)
    if m:
        try:
            out["nozzle_mm"] = float(m.group(1))
        except ValueError:
            pass

    # layer0.2mm
    m = re.search(r"layer\s*([0-9]*\.?[0-9]+)\s*mm", name_only, re.I)
    if m:
        try:
            out["layer_height_mm"] = float(m.group(1))
        except ValueError:
            pass

    # 230C or 230c for nozzle temp
    m = re.search(r"([0-9]{2,3})\s*[cC]\b", name_only)
    if m:
        try:
            out["temp_nozzle_C"] = float(m.group(1))
        except ValueError:
            pass

    # time like 1h48m
    m = re.search(r"(\d+h\d+m(?:\d+s)?)", name_only, re.I)
    if m:
        secs = _parse_time_to_seconds(m.group(1))
        if secs is not None:
            out["time_seconds"] = secs

    # Material token (common plastics)
    mats = ["PLA", "PETG", "ABS", "ASA", "TPU", "NYLON", "PC", "HIPS", "PVA", "PP"]
    for mat in mats:
        if re.search(rf"\b{mat}\b", name_only, re.I):
            out["material"] = mat.upper()
            break

    return out


def _compact(d: Dict) -> Dict:
    return {k: v for k, v in d.items() if v is not None}


def generate_index(folder_path: str):
    """Scan the provided folder for .gcode files and create index.json with metadata.

    The resulting JSON structure is a list of entries like:
    {
        "name": "file base name",
        "path": "relative/path/to/file.gcode",
        "size": 12345,
        "mtime": 1700000000,
        "meta": { ... parsed fields ... }
    }
    """
    root = os.path.abspath(folder_path)
    entries: List[Dict] = []

    for base, _, files in os.walk(root):
        for fn in files:
            if not fn.lower().endswith(".gcode"):
                continue
            full = os.path.join(base, fn)
            rel = os.path.relpath(full, root)

            # Read a limited portion of the file to parse header comments quickly
            header_lines: List[str] = []
            try:
                with open(full, "r", encoding="utf-8", errors="ignore") as f:
                    for _ in range(500):
                        ln = f.readline()
                        if not ln:
                            break
                        header_lines.append(ln.rstrip("\n"))
                        # Stop when first non-comment non-empty code appears after some comments
                        if not ln.startswith(";") and ln.strip():
                            break
            except Exception:
                header_lines = []

            hdr_meta = _parse_header_metadata(header_lines)
            name_meta = _parse_from_filename(fn)

            meta: Dict[str, Optional[float]] = {
                **name_meta,
                **{k: v for k, v in hdr_meta.items() if v is not None or name_meta.get(k) is None},
            }

            try:
                st = os.stat(full)
                size = st.st_size
                mtime = int(st.st_mtime)
            except Exception:
                size = None
                mtime = None

            entries.append({
                "name": os.path.splitext(fn)[0],
                "path": rel.replace(os.sep, "/"),
                "size": size,
                "mtime": mtime,
                "meta": _compact(meta),
            })

    # Sort by name for stability
    entries.sort(key=lambda e: e["name"].lower())

    out_path = os.path.join(root, "index.json")
    with open(out_path, "w", encoding="utf-8") as out:
        json.dump(entries, out, ensure_ascii=False, indent=2)

    return entries


if __name__ == "__main__":
    import sys
    target = sys.argv[1] if len(sys.argv) > 1 else os.path.join(os.path.dirname(__file__), "..", "gcode")
    target = os.path.abspath(target)
    print(f"Generating index for: {target}")
    entries = generate_index(target)
    print(f"Indexed {len(entries)} gcode files. Output: {os.path.join(target, 'index.json')}")
