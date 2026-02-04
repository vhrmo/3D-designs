import * as GCodePreview from 'gcode-preview';

// Helpers
function formatBytes(bytes) {
  if (bytes == null) return '';
  const thresh = 1024;
  if (Math.abs(bytes) < thresh) return bytes + ' B';
  const units = ['KB','MB','GB','TB'];
  let u = -1;
  do {
    bytes /= thresh; ++u;
  } while (Math.abs(bytes) >= thresh && u < units.length - 1);
  return bytes.toFixed(1) + ' ' + units[u];
}

function formatTime(seconds) {
  if (!seconds && seconds !== 0) return '';
  const h = Math.floor(seconds / 3600);
  const m = Math.floor((seconds % 3600) / 60);
  const s = Math.floor(seconds % 60);
  if (h > 0) return `${h}h ${m}m`;
  if (m > 0) return `${m}m ${s}s`;
  return `${s}s`;
}

function formatDate(epochSec) {
  if (!epochSec) return '';
  const d = new Date(epochSec * 1000);
  return d.toLocaleString();
}

function round(val, digits = 2) {
  if (val == null) return '';
  const f = Math.pow(10, digits);
  return Math.round(val * f) / f;
}

// Build table rows from gcode/index.json
async function initTable() {
  const tbody = document.querySelector('#gcode-table tbody');
  if (!tbody) return;
  try {
    const res = await fetch('./gcode/index.json');
    const list = await res.json();
    // TODO sort by name
    // sort by mtime desc if present
    list.sort((a,b) => (b.mtime||0) - (a.mtime||0));

    for (const item of list) {
      const tr = tbody.insertRow();
      tr.style.cursor = 'pointer';
      tr.addEventListener('click', (e) => {
        // Don't trigger if clicking on buttons or links or the mini canvas
        if (e.target.tagName === 'BUTTON' || e.target.tagName === 'A' || e.target.tagName === 'CANVAS') return;
        openPreview(item);
      });

      // Name
      const tdName = tr.insertCell();
      const link = document.createElement('a');
      link.href = `./gcode/${encodeURIComponent(item.path)}`;
      link.textContent = item.name || item.path;
      link.download = item.path;
      tdName.appendChild(link);

      // Mini Preview
      const tdPrev = tr.insertCell();
      const mini = document.createElement('canvas');
      mini.className = 'mini-preview';
      mini.width = 1; mini.height = 1; // will be resized on intersect
      mini.title = 'Click row to open large preview';
      tdPrev.appendChild(mini);
      setupMiniPreview(mini, item);

      // Size
      const tdSize = tr.insertCell();
      tdSize.textContent = formatBytes(item.size);
      tdSize.className = 'muted nowrap';

      // Modified
      const tdMtime = tr.insertCell();
      tdMtime.textContent = formatDate(item.mtime);
      tdMtime.className = 'muted nowrap';

      // Info column: show metadata as icon + "Key: Value"
      const tdInfo = tr.insertCell();
      tdInfo.className = 'nowrap';
      const iconImg = (name, size = 16) => {
        const img = document.createElement('img');
        img.src = `./node_modules/@material-icons/svg/svg/${name}/baseline.svg`;
        img.alt = '';
        img.width = size;
        img.height = size;
        img.style.verticalAlign = 'text-bottom';
        img.setAttribute('aria-hidden', 'true');
        return img;
      };
      const addInfo = (iconName, label, value) => {
        if (value === '' || value == null) return;
        const span = document.createElement('span');
        span.style.display = 'block';
        span.style.marginBottom = '2px';
        span.appendChild(iconImg(iconName, 16));
        const text = document.createTextNode(` ${label}: ${value}`);
        span.appendChild(text);
        tdInfo.appendChild(span);
      };
      addInfo('schedule', 'Time', formatTime(item.meta?.time_seconds));
      addInfo('layers', 'Layer', item.meta?.layer_height_mm != null ? `${round(item.meta.layer_height_mm,2)} mm` : '');
      addInfo('center_focus_strong', 'Nozzle', item.meta?.nozzle_mm != null ? `${round(item.meta.nozzle_mm,2)} mm` : '');
      addInfo('straighten', 'Filament', item.meta?.filament_used_m != null ? `${round(item.meta.filament_used_m,2)} m` : '');

    }
  } catch (err) {
    console.error('Failed to load index.json', err);
    const tr = tbody.insertRow();
    const td = tr.insertCell();
    td.colSpan = 5;
    td.textContent = 'Failed to load gcode/index.json';
  }
}

// Mini preview logic
const miniPreviewMap = new WeakMap();

function setupMiniPreview(miniCanvas, item) {
  // Lazy render when visible
  const io = new IntersectionObserver((entries, obs) => {
    for (const entry of entries) {
      if (entry.isIntersecting) {
        obs.unobserve(entry.target);
        renderMiniPreview(miniCanvas, item);
      }
    }
  }, { threshold: 0.2 });
  io.observe(miniCanvas);
}

function preprocessGCodeForInlinePreview(gcode) {
  // Remove intro/purge/skirt lines so the mini preview focuses on the model
  // Strategy: keep from the first known layer marker if present; otherwise return original
  const lines = gcode.split(/\r?\n/);
  const markers = [
    ';LAYER:0',
    '; LAYER:0',
    ';LAYER: 0',
    '; layer 0',
    '; layer:0',
    ';BEGIN_LAYER_OBJECT',
    '; BEGIN_LAYER_OBJECT',
    ';AFTER_LAYER_CHANGE',
    ';LAYER_CHANGE'
  ];
  let idx = -1;
  for (let i = 0; i < lines.length; i++) {
    const ln = lines[i];
    for (const m of markers) {
      if (ln.indexOf(m) !== -1) { idx = i; break; }
    }
    if (idx !== -1) break;
  }
  if (idx > 0) {
    return lines.slice(idx).join('\n');
  }
  // Fallback: if Cura/Prusa markers missing, keep from the first occurrence of ';TYPE:' (feature section)
  for (let i = 0; i < lines.length; i++) {
    if (lines[i].startsWith(';TYPE:') || lines[i].startsWith('; TYPE:')) {
      return lines.slice(i).join('\n');
    }
  }
  return gcode;
}

function renderMiniPreview(miniCanvas, item) {
  // Size backing store to devicePixelRatio once
  const rect = miniCanvas.getBoundingClientRect();
  const dpr = window.devicePixelRatio || 1;
  const w = Math.max(1, Math.floor(rect.width));
  const h = Math.max(1, Math.floor(rect.height));
  miniCanvas.width = Math.floor(w * dpr);
  miniCanvas.height = Math.floor(h * dpr);

  // Initialize a lightweight preview instance
  let inst;
  try {
    inst = GCodePreview.init({ canvas: miniCanvas, extrusionColor: '#9ca3af' });
  } catch (e) {
    // Fail silently for mini previews
    return;
  }
  miniPreviewMap.set(miniCanvas, inst);

  const url = `./gcode/${item.path}`;
  fetch(url)
    .then(r => r.text())
    .then(gcode => preprocessGCodeForInlinePreview(gcode))
    .then(g => inst.processGCode(g))
    .then(() => {
      // Prefer deterministic fit methods to ensure small models are zoomed and large ones fit
      const call = (name) => { try { typeof inst[name] === 'function' && inst[name](); } catch(_) {} };
      if (typeof inst.zoomToFit === 'function') {
        call('zoomToFit');
        call('centerView');
      } else if (typeof inst.fit === 'function') {
        call('fit');
        call('centerView');
      } else {
        // Try a few common names
        ['resetView','recenter','centerView','zoomExtents','focus','reset'].forEach(call);
      }
    })
    .catch(() => {
      // ignore mini preview errors
    });
}

// Overlay preview logic
let overlay, closeBtn, recenterBtn, infoEl, canvas, previewInstance = null;

function ensureElements() {
  overlay = document.getElementById('overlay');
  closeBtn = document.getElementById('close-overlay');
  recenterBtn = document.getElementById('recenter');
  infoEl = document.getElementById('info');
  canvas = document.getElementById('preview-canvas');
  if (closeBtn) closeBtn.addEventListener('click', closePreview);
  if (overlay) overlay.addEventListener('click', (e) => { if (e.target === overlay) closePreview(); });
  if (recenterBtn) recenterBtn.addEventListener('click', () => tryRecenter());
  window.addEventListener('keydown', (e) => { if (e.key === 'Escape') closePreview(); });
  window.addEventListener('resize', () => resizeCanvas());
}

function openPreview(item) {
  ensureElements();
  if (!overlay || !canvas) return;
  document.getElementById('dialog-title').textContent = item.name || item.path;
  overlay.classList.add('open');
  overlay.setAttribute('aria-hidden', 'false');

  // Init preview instance on demand
  if (previewInstance) {
    try { previewInstance.dispose && previewInstance.dispose(); } catch (e) {}
    previewInstance = null;
  }
  previewInstance = GCodePreview.init({ canvas, extrusionColor: 'hotpink' });
  resizeCanvas();

  const url = `./gcode/${item.path}`;
  fetch(url)
    .then(r => r.text())
    .then(gcode => {
      infoEl.textContent = 'Loading...';
      return previewInstance.processGCode(gcode).then(() => gcode);
    })
    .then(gcode => {
      infoEl.textContent = `${(gcode.length/1024/1024).toFixed(2)} MB | ${formatTime(item.meta?.time_seconds)}`;
      tryRecenter();
    })
    .catch(err => {
      console.error('Preview failed', err);
      infoEl.textContent = 'Preview failed';
    });
}

function resizeCanvas() {
  if (!canvas || !canvas.parentElement) return;
  const rect = canvas.parentElement.getBoundingClientRect();
  const dpr = window.devicePixelRatio || 1;
  const w = Math.max(1, Math.floor(rect.width));
  const h = Math.max(1, Math.floor(rect.height));
  canvas.width = Math.floor(w * dpr);
  canvas.height = Math.floor(h * dpr);
  canvas.style.width = w + 'px';
  canvas.style.height = h + 'px';
  if (previewInstance && previewInstance.resize) {
    try { previewInstance.resize(); } catch (e) {}
  }
}

function tryRecenter() {
  if (!previewInstance) return;
  const candidates = ['centerView','reset','recenter','resetView','focus','fit','zoomToFit','zoomExtents'];
  for (const m of candidates) {
    const fn = previewInstance[m];
    if (typeof fn === 'function') {
      try { fn.call(previewInstance); return; } catch(e) {}
    }
  }
}

function closePreview() {
  if (!overlay) return;
  overlay.classList.remove('open');
  overlay.setAttribute('aria-hidden', 'true');
  if (previewInstance) {
    try { previewInstance.dispose && previewInstance.dispose(); } catch (e) {}
    previewInstance = null;
  }
}

initTable();
