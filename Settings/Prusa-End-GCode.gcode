G91         ; Relative Positioning
G0 X10 Z10  ; Move head 10mm up
G1 X5 Y170 F{travel_speed*60} ; present print
M140 S0 ; turn off heatbed
M104 S0 ; turn off temperature
M107    ; Fan off
M18     ; disable motors
G90     ; Absolute Positioning
