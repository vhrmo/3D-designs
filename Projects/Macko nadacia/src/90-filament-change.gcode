


; move head away and retract filament
G1 X4 Y10 Z20 E-200 F4000

; retract
G1 E-200 F4000

; pause
M76


; prime filament
G1 X6 Y10 F3000
G1 Z0.16 F240
G92 E0
G1 Y190 E15 F1500 ; intro line
G1 X6.3 F5000
G92 E0
G1 Y10 E15 F1200 ; intro line
G92 E0

