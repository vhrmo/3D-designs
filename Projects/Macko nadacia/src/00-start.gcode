
; Initial setup + purge line


M201 X500 Y500 Z100 E5000 ; sets maximum accelerations, mm/sec^2
M203 X500 Y500 Z10 E60 ; sets maximum feedrates, mm/sec
M204 P500 R1000 T500 ; sets acceleration (P, T) and retract acceleration (R), mm/sec^2
M205 X8.00 Y8.00 Z0.40 E5.00 ; sets the jerk limits, mm/sec
M205 S0 T0 ; sets the minimum extruding and travel feed rate, mm/sec
M107

;TYPE:Custom
G21 ; set units to millimeters
G90 ; use absolute coordinates
M83 ; extruder relative mode
M104 S220 ; set extruder temp
M140 S70 ; set bed temp
G28 ; home all
M420 S1  ; restore ABL mesh
G1 Z10.0; Move Z Axis up to prevent from heating up too close to the bed
M190 S70 ; wait for bed temp
M109 S220 ; wait for extruder temp

; Purge line at the side of the print bed
G1 X2 Y10 F3000
G1 Z0.16 F240
G92 E0
G1 Y190 E15 F1500 ; intro line
G1 X2.3 F5000
G92 E0
G1 Y10 E15 F1200 ; intro line
G92 E0
