; Purge line at the side of the print bed
G1 Z2 F240
G1 X2 Y10 F3000
G1 Z0.28 F240
G92 E0
G1 Y190 E15 F1500 ; intro line
G1 X2.3 F5000
G92 E0
G1 Y10 E15 F1200 ; intro line
G92 E0
G21 ; set units to millimeters
G90 ; use absolute coordinates
M83 ; use relative distances for extrusion
; Filament gcode
;LAYER_CHANGE
;Z:0.28
;HEIGHT:0.28
;BEFORE_LAYER_CHANGE
G92 E0
;0.28


G1 E-5.00000 F3600.000 ; retract
G1 Z0.280 F9000.000 ; move to next layer (0)
;AFTER_LAYER_CHANGE
;0.28
G1 X26.859 Y48.544 ; move to first skirt point
G1 E5.00000 F2400.000 ; unretract
M204 S500 ; adjust acceleration
;TYPE:Skirt
;WIDTH:1.125
G1 F1200.000
G1 X28.366 Y47.732 E0.21230 ; skirt
G3 X31.628 Y47.016 I3.510 J8.203 E0.41614; skirt
G1 X200.481 Y47.016 E20.93222 ; skirt
G1 X201.877 Y47.167 E0.17400 ; skirt
G3 X203.711 Y47.716 I-1.576 J8.602 E0.23775; skirt
G1 X205.367 Y48.622 E0.23396 ; skirt
G1 X206.762 Y49.814 E0.22747 ; skirt
G1 X207.917 Y51.311 E0.23438 ; skirt
G1 X210.906 Y56.318 E0.72288 ; skirt
G1 X211.425 Y57.472 E0.15679 ; skirt
G1 X211.703 Y58.650 E0.15014 ; skirt
G1 X211.770 Y59.566 E0.11386 ; skirt
G1 X211.759 Y93.983 E4.26647 ; skirt
G1 X211.473 Y95.200 E0.15499 ; skirt
G1 X210.831 Y96.273 E0.15499 ; skirt
G1 X209.894 Y97.100 E0.15499 ; skirt
G1 X208.744 Y97.604 E0.15560 ; skirt
G1 X207.710 Y97.739 E0.12931 ; skirt
G1 X23.846 Y97.739 E22.79307 ; skirt

; vhr added move
G1 X23.846 Y96
G1 X115.806 Y96
G1 X115.806 Y93.012 ; move to first perimeter point

;TYPE:External perimeter
G1 F1200.000
G1 X24.568 Y93.012 E11.31043 ; perimeter
G1 X24.568 Y83.735 E1.14996 ; perimeter
G1 X26.124 Y83.720 E0.19292 ; perimeter
G2 X26.814 Y83.436 I-0.527 J-2.260 E0.09276; perimeter
G2 X27.468 Y82.104 I-1.439 J-1.533 E0.18853; perimeter
G1 X27.468 Y72.898 E1.14117 ; perimeter
G2 X26.164 Y71.363 I-1.616 J0.051 E0.26920; perimeter
G3 X26.164 Y67.785 I0.742 J-1.789 E0.56466; perimeter
G2 X27.468 Y66.250 I-0.312 J-1.586 E0.26920; perimeter
G1 X27.468 Y62.898 E0.41552 ; perimeter
G2 X26.164 Y61.363 I-1.616 J0.051 E0.26920; perimeter
G3 X26.164 Y57.785 I0.742 J-1.789 E0.56452; perimeter
G2 X27.440 Y56.538 I-0.348 J-1.633 E0.23331; perimeter
G3 X28.374 Y53.389 I5.204 J-0.170 E0.41499; perimeter
G3 X36.316 Y55.595 I3.532 J2.685 E1.31024; perimeter
G1 X36.371 Y56.538 E0.11711 ; perimeter
G2 X37.647 Y57.785 I1.597 J-0.358 E0.23331; perimeter
G3 X37.647 Y61.363 I-0.742 J1.789 E0.56467; perimeter
G2 X36.343 Y62.898 I0.312 J1.586 E0.26920; perimeter
G1 X36.343 Y66.250 E0.41552 ; perimeter
G2 X37.647 Y67.785 I1.616 J-0.051 E0.26920; perimeter
G3 X37.647 Y71.363 I-0.742 J1.789 E0.56467; perimeter
G2 X36.343 Y72.898 I0.312 J1.586 E0.26922; perimeter
G1 X36.349 Y82.238 E1.15780 ; perimeter
G2 X37.528 Y83.684 I1.719 J-0.198 E0.24450; perimeter
G1 X37.858 Y83.731 E0.04130 ; perimeter
G1 X41.409 Y83.725 E0.44028 ; perimeter
G2 X42.091 Y83.453 I-0.579 J-2.442 E0.09115; perimeter
G2 X42.768 Y82.104 I-1.388 J-1.541 E0.19202; perimeter
G1 X42.768 Y72.898 E1.14117 ; perimeter
G2 X41.464 Y71.363 I-1.616 J0.051 E0.26920; perimeter
G3 X41.464 Y67.785 I0.742 J-1.789 E0.56466; perimeter
G2 X42.768 Y66.250 I-0.312 J-1.586 E0.26920; perimeter
G1 X42.768 Y62.898 E0.41553 ; perimeter
G2 X41.464 Y61.363 I-1.616 J0.051 E0.26920; perimeter
G3 X41.464 Y57.785 I0.742 J-1.789 E0.56450; perimeter
G2 X42.740 Y56.538 I-0.348 J-1.633 E0.23331; perimeter
G3 X43.674 Y53.389 I5.204 J-0.170 E0.41499; perimeter
G3 X51.616 Y55.595 I3.532 J2.685 E1.31024; perimeter
G1 X51.671 Y56.538 E0.11711 ; perimeter
G2 X52.947 Y57.785 I1.597 J-0.358 E0.23331; perimeter
G3 X52.947 Y61.363 I-0.742 J1.789 E0.56467; perimeter
G2 X51.643 Y62.898 I0.312 J1.586 E0.26920; perimeter
G1 X51.643 Y66.250 E0.41553 ; perimeter
G2 X52.947 Y67.785 I1.616 J-0.051 E0.26919; perimeter
G3 X52.947 Y71.363 I-0.742 J1.789 E0.56466; perimeter
G2 X51.643 Y72.898 I0.339 J1.610 E0.26920; perimeter
G1 X51.649 Y82.238 E1.15780 ; perimeter
G2 X52.829 Y83.684 I1.719 J-0.198 E0.24462; perimeter
G2 X53.675 Y83.736 I0.618 J-3.154 E0.10536; perimeter
G1 X56.709 Y83.725 E0.37611 ; perimeter
G2 X57.391 Y83.453 I-0.579 J-2.442 E0.09115; perimeter
G2 X58.068 Y82.104 I-1.388 J-1.541 E0.19202; perimeter
G1 X58.068 Y72.898 E1.14117 ; perimeter
G2 X56.764 Y71.363 I-1.616 J0.051 E0.26920; perimeter
G3 X56.764 Y67.785 I0.742 J-1.789 E0.56464; perimeter
G2 X58.068 Y66.250 I-0.312 J-1.586 E0.26919; perimeter
G1 X58.068 Y62.898 E0.41552 ; perimeter
G2 X56.764 Y61.363 I-1.616 J0.051 E0.26920; perimeter
G3 X56.764 Y57.785 I0.742 J-1.789 E0.56458; perimeter
G2 X58.040 Y56.538 I-0.348 J-1.633 E0.23331; perimeter
G3 X58.974 Y53.389 I5.204 J-0.170 E0.41499; perimeter
G3 X66.916 Y55.595 I3.532 J2.685 E1.31023; perimeter
G1 X66.971 Y56.538 E0.11711 ; perimeter
G2 X68.247 Y57.785 I1.597 J-0.358 E0.23331; perimeter
G3 X68.247 Y61.363 I-0.742 J1.789 E0.56458; perimeter
G2 X66.943 Y62.898 I0.312 J1.586 E0.26920; perimeter
G1 X66.943 Y66.250 E0.41552 ; perimeter
G2 X68.247 Y67.785 I1.616 J-0.051 E0.26920; perimeter
G3 X68.247 Y71.363 I-0.742 J1.789 E0.56467; perimeter
G2 X66.943 Y72.898 I0.339 J1.610 E0.26920; perimeter
G1 X66.949 Y82.238 E1.15780 ; perimeter
G2 X68.129 Y83.684 I1.719 J-0.198 E0.24462; perimeter
G1 X68.458 Y83.731 E0.04118 ; perimeter
G1 X72.009 Y83.725 E0.44029 ; perimeter
G2 X72.691 Y83.453 I-0.579 J-2.442 E0.09115; perimeter
G2 X73.368 Y82.104 I-1.388 J-1.541 E0.19202; perimeter
G1 X73.368 Y72.898 E1.14117 ; perimeter
G2 X72.064 Y71.363 I-1.616 J0.051 E0.26920; perimeter
G3 X72.064 Y67.785 I0.742 J-1.789 E0.56464; perimeter
G2 X73.368 Y66.250 I-0.312 J-1.586 E0.26920; perimeter
G1 X73.368 Y62.898 E0.41552 ; perimeter
G2 X72.064 Y61.363 I-1.616 J0.051 E0.26920; perimeter
G3 X72.064 Y57.785 I0.742 J-1.789 E0.56466; perimeter
G2 X73.340 Y56.538 I-0.348 J-1.633 E0.23331; perimeter
G3 X74.274 Y53.389 I5.204 J-0.170 E0.41499; perimeter
G3 X82.216 Y55.595 I3.532 J2.685 E1.31023; perimeter
G1 X82.271 Y56.538 E0.11711 ; perimeter
G2 X83.547 Y57.785 I1.597 J-0.358 E0.23331; perimeter
G3 X83.547 Y61.363 I-0.742 J1.789 E0.56458; perimeter
G2 X82.243 Y62.898 I0.312 J1.586 E0.26920; perimeter
G1 X82.243 Y66.250 E0.41552 ; perimeter
G2 X83.547 Y67.785 I1.616 J-0.051 E0.26920; perimeter
G3 X83.547 Y71.363 I-0.742 J1.789 E0.56465; perimeter
G2 X82.243 Y72.898 I0.339 J1.610 E0.26920; perimeter
G1 X82.249 Y82.238 E1.15780 ; perimeter
G2 X83.429 Y83.684 I1.719 J-0.198 E0.24462; perimeter
G1 X83.761 Y83.732 E0.04158 ; perimeter
G1 X87.309 Y83.725 E0.43983 ; perimeter
G2 X87.991 Y83.453 I-0.592 J-2.474 E0.09122; perimeter
G2 X88.668 Y82.104 I-1.388 J-1.541 E0.19202; perimeter
G1 X88.668 Y72.898 E1.14117 ; perimeter
G2 X87.364 Y71.363 I-1.616 J0.051 E0.26920; perimeter
G3 X87.364 Y67.785 I0.742 J-1.789 E0.56466; perimeter
G2 X88.668 Y66.250 I-0.312 J-1.586 E0.26919; perimeter
G1 X88.668 Y62.898 E0.41553 ; perimeter
G2 X87.364 Y61.363 I-1.616 J0.051 E0.26920; perimeter
G3 X87.364 Y57.785 I0.742 J-1.789 E0.56466; perimeter
G2 X88.640 Y56.538 I-0.348 J-1.633 E0.23331; perimeter
G3 X89.574 Y53.389 I5.204 J-0.170 E0.41499; perimeter
G3 X97.516 Y55.595 I3.532 J2.685 E1.31023; perimeter
G1 X97.571 Y56.538 E0.11711 ; perimeter
G2 X98.847 Y57.785 I1.597 J-0.358 E0.23331; perimeter
G3 X98.847 Y61.363 I-0.742 J1.789 E0.56458; perimeter
G2 X97.543 Y62.898 I0.312 J1.586 E0.26920; perimeter
G1 X97.543 Y66.250 E0.41552 ; perimeter
G2 X98.847 Y67.785 I1.616 J-0.051 E0.26920; perimeter
G3 X98.847 Y71.363 I-0.742 J1.789 E0.56466; perimeter
G2 X97.543 Y72.898 I0.339 J1.610 E0.26918; perimeter
G1 X97.543 Y82.118 E1.14300 ; perimeter
G2 X99.061 Y83.732 I1.668 J-0.048 E0.30095; perimeter
G1 X102.609 Y83.725 E0.43984 ; perimeter
G2 X103.295 Y83.451 I-0.583 J-2.454 E0.09189; perimeter
G2 X103.968 Y82.104 I-1.403 J-1.542 E0.19140; perimeter
G1 X103.968 Y72.898 E1.14117 ; perimeter
G2 X102.664 Y71.363 I-1.616 J0.051 E0.26920; perimeter
G3 X102.664 Y67.785 I0.742 J-1.789 E0.56464; perimeter
G2 X103.968 Y66.250 I-0.312 J-1.586 E0.26919; perimeter
G1 X103.968 Y62.898 E0.41552 ; perimeter
G2 X102.664 Y61.363 I-1.616 J0.051 E0.26920; perimeter
G3 X102.664 Y57.785 I0.742 J-1.789 E0.56466; perimeter
G2 X103.940 Y56.538 I-0.348 J-1.633 E0.23331; perimeter
G3 X104.874 Y53.389 I5.204 J-0.170 E0.41499; perimeter
G3 X112.816 Y55.595 I3.532 J2.685 E1.31023; perimeter
G1 X112.871 Y56.538 E0.11711 ; perimeter
G2 X114.147 Y57.785 I1.597 J-0.358 E0.23331; perimeter
G3 X114.147 Y61.363 I-0.742 J1.789 E0.56458; perimeter
G2 X112.843 Y62.898 I0.312 J1.586 E0.26920; perimeter
G1 X112.843 Y66.250 E0.41552 ; perimeter
G2 X114.147 Y67.785 I1.616 J-0.051 E0.26920; perimeter
G3 X114.147 Y71.363 I-0.742 J1.789 E0.56466; perimeter
G2 X112.843 Y72.898 I0.339 J1.610 E0.26921; perimeter
G1 X112.849 Y82.238 E1.15780 ; perimeter
G2 X114.029 Y83.684 I1.719 J-0.198 E0.24462; perimeter
G1 X114.361 Y83.732 E0.04158 ; perimeter
G1 X117.909 Y83.725 E0.43984 ; perimeter
G2 X118.590 Y83.453 I-0.572 J-2.421 E0.09119; perimeter
G2 X119.268 Y82.104 I-1.381 J-1.539 E0.19202; perimeter
G1 X119.268 Y72.898 E1.14117 ; perimeter
G2 X117.964 Y71.363 I-1.616 J0.051 E0.26920; perimeter
G3 X117.964 Y67.785 I0.742 J-1.789 E0.56465; perimeter
G2 X119.268 Y66.250 I-0.312 J-1.586 E0.26920; perimeter
G1 X119.268 Y62.898 E0.41553 ; perimeter
G2 X117.964 Y61.363 I-1.616 J0.051 E0.26920; perimeter
G3 X117.964 Y57.785 I0.742 J-1.789 E0.56466; perimeter
G2 X119.240 Y56.538 I-0.348 J-1.633 E0.23331; perimeter
G3 X120.174 Y53.389 I5.204 J-0.170 E0.41499; perimeter
G3 X128.116 Y55.595 I3.532 J2.685 E1.31023; perimeter
G1 X128.171 Y56.538 E0.11711 ; perimeter
G2 X129.447 Y57.785 I1.597 J-0.358 E0.23331; perimeter
G3 X129.447 Y61.363 I-0.742 J1.789 E0.56458; perimeter
G2 X128.143 Y62.898 I0.312 J1.586 E0.26920; perimeter
G1 X128.143 Y66.250 E0.41552 ; perimeter
G2 X129.447 Y67.785 I1.616 J-0.051 E0.26919; perimeter
G3 X129.447 Y71.363 I-0.742 J1.789 E0.56466; perimeter
G2 X128.143 Y72.898 I0.312 J1.586 E0.26922; perimeter
G1 X128.149 Y82.238 E1.15780 ; perimeter
G2 X129.329 Y83.684 I1.719 J-0.198 E0.24462; perimeter
G1 X129.658 Y83.731 E0.04118 ; perimeter
G1 X133.224 Y83.720 E0.44215 ; perimeter
G2 X133.895 Y83.451 I-0.580 J-2.419 E0.08988; perimeter
G2 X134.568 Y82.104 I-1.403 J-1.542 E0.19142; perimeter
G1 X134.568 Y72.898 E1.14117 ; perimeter
G2 X133.264 Y71.363 I-1.616 J0.051 E0.26920; perimeter
G3 X133.264 Y67.785 I0.742 J-1.789 E0.56465; perimeter
G2 X134.568 Y66.250 I-0.312 J-1.586 E0.26920; perimeter
G1 X134.568 Y62.898 E0.41552 ; perimeter
G2 X133.264 Y61.363 I-1.616 J0.051 E0.26920; perimeter
G3 X133.264 Y57.785 I0.742 J-1.789 E0.56466; perimeter
G2 X134.540 Y56.538 I-0.348 J-1.633 E0.23331; perimeter
G3 X135.474 Y53.389 I5.204 J-0.170 E0.41499; perimeter
G3 X143.416 Y55.595 I3.532 J2.685 E1.31023; perimeter
G1 X143.471 Y56.538 E0.11711 ; perimeter
G2 X144.747 Y57.785 I1.597 J-0.358 E0.23331; perimeter
G3 X144.747 Y61.363 I-0.742 J1.789 E0.56458; perimeter
G2 X143.443 Y62.898 I0.312 J1.586 E0.26920; perimeter
G1 X143.443 Y66.250 E0.41552 ; perimeter
G2 X144.747 Y67.785 I1.616 J-0.051 E0.26920; perimeter
G3 X144.747 Y71.363 I-0.742 J1.789 E0.56466; perimeter
G2 X143.443 Y72.898 I0.339 J1.610 E0.26920; perimeter
G1 X143.449 Y82.238 E1.15780 ; perimeter
G2 X144.629 Y83.684 I1.719 J-0.198 E0.24462; perimeter
G1 X144.958 Y83.731 E0.04118 ; perimeter
G1 X148.524 Y83.720 E0.44215 ; perimeter
G2 X149.195 Y83.451 I-0.580 J-2.419 E0.08988; perimeter
G2 X149.868 Y82.104 I-1.405 J-1.544 E0.19140; perimeter
G1 X149.868 Y72.898 E1.14117 ; perimeter
G2 X148.564 Y71.363 I-1.616 J0.051 E0.26920; perimeter
G3 X148.564 Y67.785 I0.742 J-1.789 E0.56466; perimeter
G2 X149.868 Y66.250 I-0.312 J-1.586 E0.26920; perimeter
G1 X149.868 Y62.898 E0.41552 ; perimeter
G2 X148.564 Y61.363 I-1.616 J0.051 E0.26920; perimeter
G3 X148.564 Y57.785 I0.742 J-1.789 E0.56467; perimeter
G2 X149.840 Y56.538 I-0.348 J-1.633 E0.23331; perimeter
G3 X150.774 Y53.389 I5.204 J-0.170 E0.41499; perimeter
G3 X158.716 Y55.595 I3.532 J2.685 E1.31024; perimeter
G1 X158.771 Y56.538 E0.11711 ; perimeter
G2 X160.047 Y57.785 I1.597 J-0.358 E0.23331; perimeter
G3 X160.047 Y61.363 I-0.742 J1.789 E0.56461; perimeter
G2 X158.743 Y62.898 I0.312 J1.586 E0.26920; perimeter
G1 X158.743 Y66.250 E0.41553 ; perimeter
G2 X160.047 Y67.785 I1.616 J-0.051 E0.26920; perimeter
G3 X160.047 Y71.363 I-0.742 J1.789 E0.56467; perimeter
G2 X158.743 Y72.898 I0.339 J1.610 E0.26920; perimeter
G1 X158.749 Y82.238 E1.15780 ; perimeter
G2 X159.929 Y83.684 I1.719 J-0.198 E0.24462; perimeter
G1 X160.258 Y83.731 E0.04118 ; perimeter
G1 X163.809 Y83.725 E0.44030 ; perimeter
G2 X164.490 Y83.453 I-0.585 J-2.452 E0.09113; perimeter
G2 X165.168 Y82.104 I-1.381 J-1.539 E0.19203; perimeter
G1 X165.168 Y72.898 E1.14117 ; perimeter
G2 X163.864 Y71.363 I-1.616 J0.051 E0.26920; perimeter
G3 X163.864 Y67.785 I0.742 J-1.789 E0.56466; perimeter
G2 X165.168 Y66.250 I-0.312 J-1.586 E0.26920; perimeter
G1 X165.168 Y62.898 E0.41552 ; perimeter
G2 X163.864 Y61.363 I-1.616 J0.051 E0.26920; perimeter
G3 X163.864 Y57.785 I0.742 J-1.789 E0.56468; perimeter
G2 X165.140 Y56.538 I-0.348 J-1.633 E0.23332; perimeter
G3 X166.074 Y53.389 I5.204 J-0.170 E0.41499; perimeter
G3 X174.016 Y55.595 I3.532 J2.685 E1.31024; perimeter
G1 X174.071 Y56.538 E0.11710 ; perimeter
G2 X175.347 Y57.785 I1.597 J-0.358 E0.23331; perimeter
G3 X175.347 Y61.363 I-0.742 J1.789 E0.56460; perimeter
G2 X174.043 Y62.898 I0.312 J1.586 E0.26920; perimeter
G1 X174.043 Y66.250 E0.41553 ; perimeter
G2 X175.347 Y67.785 I1.616 J-0.051 E0.26920; perimeter
G3 X175.347 Y71.363 I-0.742 J1.789 E0.56465; perimeter
G2 X174.043 Y72.898 I0.312 J1.586 E0.26922; perimeter
G1 X174.049 Y82.238 E1.15780 ; perimeter
G2 X175.229 Y83.684 I1.719 J-0.198 E0.24463; perimeter
G1 X175.558 Y83.731 E0.04118 ; perimeter
G1 X179.109 Y83.725 E0.44031 ; perimeter
G2 X179.790 Y83.453 I-0.585 J-2.452 E0.09112; perimeter
G2 X180.468 Y82.104 I-1.381 J-1.539 E0.19203; perimeter
G1 X180.468 Y72.898 E1.14117 ; perimeter
G2 X179.164 Y71.363 I-1.616 J0.051 E0.26921; perimeter
G3 X179.164 Y67.785 I0.742 J-1.789 E0.56465; perimeter
G2 X180.468 Y66.250 I-0.312 J-1.586 E0.26921; perimeter
G1 X180.468 Y62.898 E0.41553 ; perimeter
G2 X179.164 Y61.363 I-1.616 J0.051 E0.26921; perimeter
G3 X179.164 Y57.785 I0.742 J-1.789 E0.56466; perimeter
G2 X180.440 Y56.538 I-0.348 J-1.633 E0.23331; perimeter
G3 X181.374 Y53.389 I5.204 J-0.170 E0.41499; perimeter
G3 X189.316 Y55.595 I3.532 J2.685 E1.31023; perimeter
G1 X189.371 Y56.538 E0.11710 ; perimeter
G2 X190.647 Y57.785 I1.597 J-0.358 E0.23332; perimeter
G3 X190.647 Y61.363 I-0.742 J1.789 E0.56452; perimeter
G2 X189.343 Y62.898 I0.312 J1.586 E0.26920; perimeter
G1 X189.343 Y66.250 E0.41552 ; perimeter
G2 X190.647 Y67.785 I1.616 J-0.051 E0.26920; perimeter
G3 X190.647 Y71.363 I-0.742 J1.789 E0.56468; perimeter
G2 X189.343 Y72.898 I0.312 J1.586 E0.26923; perimeter
G1 X189.349 Y82.238 E1.15780 ; perimeter
G2 X190.529 Y83.684 I1.719 J-0.198 E0.24463; perimeter
G1 X190.858 Y83.731 E0.04118 ; perimeter
G1 X194.409 Y83.725 E0.44031 ; perimeter
G2 X195.090 Y83.453 I-0.585 J-2.452 E0.09113; perimeter
G2 X195.768 Y82.103 I-1.381 J-1.539 E0.19204; perimeter
G1 X195.768 Y72.898 E1.14116 ; perimeter
G2 X194.464 Y71.363 I-1.616 J0.051 E0.26920; perimeter
G3 X194.464 Y67.785 I0.742 J-1.789 E0.56468; perimeter
G2 X195.768 Y66.250 I-0.312 J-1.586 E0.26920; perimeter
G1 X195.768 Y62.898 E0.41552 ; perimeter
G2 X194.464 Y61.363 I-1.616 J0.051 E0.26920; perimeter
G3 X194.464 Y57.785 I0.742 J-1.789 E0.56470; perimeter
G2 X195.740 Y56.538 I-0.348 J-1.633 E0.23332; perimeter
G3 X196.674 Y53.389 I5.204 J-0.170 E0.41498; perimeter
G3 X204.616 Y55.595 I3.532 J2.685 E1.31023; perimeter
G1 X204.671 Y56.538 E0.11711 ; perimeter
G2 X205.947 Y57.785 I1.597 J-0.358 E0.23331; perimeter
G3 X205.947 Y61.363 I-0.742 J1.789 E0.56450; perimeter
G2 X204.643 Y62.898 I0.312 J1.586 E0.26919; perimeter
G1 X204.643 Y66.250 E0.41552 ; perimeter
G2 X205.947 Y67.785 I1.616 J-0.051 E0.26919; perimeter
G3 X205.947 Y71.363 I-0.742 J1.789 E0.56465; perimeter
G2 X204.643 Y72.898 I0.312 J1.586 E0.26919; perimeter
G1 X204.643 Y82.118 E1.14300 ; perimeter
G2 X206.159 Y83.732 I1.668 J-0.048 E0.30077; perimeter
G1 X207.043 Y83.735 E0.10955 ; perimeter
G1 X207.043 Y93.012 E1.15003 ; perimeter
G1 X115.956 Y93.012 E11.29183 ; perimeter
G1 X115.277 Y92.163 F9000.000 ; move inwards before travel