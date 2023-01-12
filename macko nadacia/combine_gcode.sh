#!/bin/zsh

OUT="target/Macko_nozzle0.3_layer0.2_220C_PLA.gcode"

echo Generating GCODE

base_gcode() {
  cat "src/01-base.gcode"
}

macko_gcode() {
  cat "src/02-macko.gcode"
}

offset1() {
  echo "M206 X0 Y0; set offset for print #1"
}

offset2() {
  echo "M206 X-100 Y0; set offset for print #2"
}

offset3() {
  echo "M206 X0 Y-100 ; set offset for print #3"
}

offset4() {
  echo "M206 X-100 Y-100 ; set offset for print #4"
}

filament_change() {
  cat "src/90-filament-change.gcode"
}

{
  cat "src/00-start.gcode"

  offset1
  base_gcode
#  offset2
#  base_gcode
#  offset3
#  base_gcode
#  offset4
#  base_gcode

  filament_change

  offset1
  macko_gcode
#  offset2
#  macko_gcode
#  offset3
#  macko_gcode
#  offset4
#  macko_gcode

  cat "src/99-end.gcode"

} > $OUT







