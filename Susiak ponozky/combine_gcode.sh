#!/bin/zsh

OUT="susiak_ponozky_nozzle1_layer0.28_230C_PETG.gcode"

echo Generating GCODE

next_layer_gcode() {
  echo "G1 X207.043 Y93.012 Z$1 E0.5"
}


cat "./00 - start code.gcode" > $OUT
cat "./01 - base layers.gcode" >> $OUT

# Set flow rate to 95% after initial layer
echo "M221 S95 ; set flow rate to 95%" >> $OUT

for i in $(seq .56 .28 3.081)
do
  echo LAYER "$i" ;
  next_layer_gcode "$i"  >> $OUT
  cat "./01 - base layers.gcode" >> $OUT
done;


cat "./02 - clip holder.gcode" >> $OUT


cat "./99 - end code.gcode" >> $OUT

