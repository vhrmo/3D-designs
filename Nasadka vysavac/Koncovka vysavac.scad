
width = 60;
height = 16;
length = 200;
thickness = 2;

// hose diameter in mm
hose1 = 32;
// cylindrical hose shape
hose2 = 30;
hoselength=40;
hosethickness=2;


// base box
module inner_shape() {
    offset(thickness) square([width-4*thickness, height - 4*thickness], center=true);
}

module outer_shape() {
    offset(thickness) inner_shape();
}

module obluk() {
    rotate_extrude(angle = 60) {   
        translate([60,0,0])
        rotate([0,0,90])
        difference() {
            outer_shape();
            inner_shape();
        }
    }
}


module klin() {
    hull() {
        linear_extrude(height = 2) {
            outer_shape();
        }
        translate([0,0,28]) linear_extrude(height = 2) {
            inner_shape();
        }
    }
}

module join1() {
    difference() {
        klin();
        resize([width-2*thickness,height-2*thickness,0]) klin();
    }
}


module join2() {
    difference() {
        linear_extrude(height = 30) {
            outer_shape();
        }
        klin();
    }
}

// blok s plochym dnom
module body0() {
    union() {
        linear_extrude(height = length) {
            outer_shape();
        }
        *linear_extrude(height = length) {
            translate([0,-height/4,0]) 
                square([width,height/2], center=true);
        }
    }
}


// zaokruhlenie 
module body1() {
    $fa = 6;
    intersection() {
        body0();
        resize([width*1.4,height*2,0]) 
        translate([0,-height*3,length]) 
        sphere(length);
    }
}

//!body();

// vytvorenie dutiny
module body2() {
    difference() {
        body1();
        translate([0,0,4]) resize([width-2*thickness,height-2*thickness,0]) body1();
        translate([0,0,2]) resize([width-2*thickness,height-2*thickness,length-2*thickness]) body1();
    }
}

module opening() {
    hull(){
    intersection() {
        body2();
        translate([-width/2,-height/2,0]) cube([width,thickness,length]);
    }
}
}

// vytvorenie otvorov
module body3() {
    difference() {
        body2();
        translate([width/2-12,0,10]) resize([8,0,length-20]) opening();
        translate([-width/2+12,0,10]) resize([8,0,length-20]) opening();
        translate([-5,-height/2,0]) cube([10,thickness*2,100]);
        translate([-5,-height/2-thickness+0.6,108]) cube([10,thickness,length-100-14]);
    }
}

// pridanie pripojky
module body4() {
    union() {
        join1();
        translate([0,0,-length]) body3();
    }
}

module body() {
    offset = 55;
    union() {
        #translate([8,-height/2+thickness,-length+offset]) cube([3,height-2*thickness,length-offset+30]);
        #translate([-8-3,-height/2+thickness,-length+offset]) cube([3,height-2*thickness,length-offset+30]);
        body4();
    }
}

module hose() {
    part1 = 20;
    difference() {
        hull() {
            translate([0,0,part1]) 
                cylinder(hoselength, hosethickness+hose2/2, hosethickness+hose1/2);
            linear_extrude(height = part1) {
                offset(hosethickness) 
                    outer_shape();
            }
        }
        linear_extrude(height = part1) {
            outer_shape();
        }
        translate([0,0,part1]) 
            cylinder(hoselength, hose2/2, hose1/2);    
        translate([0,0,10])
            cylinder(part1-10, height/2, hose1/2);
    }
}

// Hose adapter
module part1() {
    translate([0,100,0]) hose();
}

// Obluk
module part2() {
    union() {
        obluk();
        translate([60,-30,0]) rotate([0,90,90]) join2();
    }
}



// Body
module part3() {
    translate([60,-80,0])
    rotate([0,90,90])
    body();
}




//body();
part1();
part2();
part3();








