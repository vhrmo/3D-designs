#!/bin/zsh

# -g required for Marlin 2
# --allow-3d-arcs required for Vase mode

#./ArcWelder *.gcode --allow-3d-arcs -r=0.6 -g

# loop through all the *.gcode files in the current directory - output file with added suffix _arc
for file in *.gcode; do
    # skip already welded files
    if [[ $file == *"_arc.gcode" ]]; then
        continue
    fi
    echo $file
    ./ArcWelder $file "$(basename $file '.gcode')_arc.gcode" --allow-3d-arcs -r=0.6 -g
done
