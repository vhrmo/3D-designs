
import * as GCodePreview from 'gcode-preview';

let canvas = document.querySelector('canvas');
const preview = GCodePreview.init({
    canvas: canvas,
    extrusionColor: 'hotpink'
});


fetch('./gcode/lever_arm_for_clamp_6_inch.gcode')
    .then(response => response.text())
    .then(gcode => preview.processGCode(gcode))
    .catch(error => console.error(error));
