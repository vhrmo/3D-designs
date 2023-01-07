
; When changing, same gcode should be set up in TFT screen's 'config.ini' for the print cancel command

; Set temp to 0
M104 S0
M140 S0

G91     ; Relative Positioning
G0 Z10  ; Move head 10mm up
M107    ; Fan off
M18     ; disable motors
G90     ; Absolute Positioning
