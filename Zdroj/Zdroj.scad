origVyska = 83.4;

// rozmery zdroja
hlbka = 150;
sirka = 141.5;
vyskaAddOn = 4;
vyska = origVyska+vyskaAddOn;
stena = 2;

// vonkajsie rozmery
module outerBox() {
    cube([sirka+2*stena,hlbka+2*stena,vyska+stena]);
}

module innerBox() {
    cube([sirka,hlbka,vyska]);
}

module box1() {
    difference() {
        outerBox();
        translate([stena,stena,0]) innerBox();
    }
}

// box aj s otvormi
module box2() {
    difference() {
        box1();
        napajaciKabel();
        vetranie1();
        vetranie2();
    }
}

// pridanie stlpikov
module box3() {
    stlpikX=12;
    stlpikY=15;
    union() {
        box2();
        translate([0,0,origVyska]) cube([stlpikX,stlpikY,vyskaAddOn]);
        translate([sirka+2*stena-stlpikX,0,origVyska]) cube([stlpikX,stlpikY,vyskaAddOn]);
        translate([0,hlbka+2*stena-stlpikY,origVyska]) cube([stlpikX,stlpikY,vyskaAddOn]);
        translate([sirka+2*stena-stlpikX,hlbka+2*stena-stlpikY,origVyska]) cube([stlpikX,stlpikY,vyskaAddOn]);
        
    }
}


module krytVentilator() {
    // 60 odpredu
    translate([0,60+76/2+stena,origVyska/2]) rotate([0,90,0]) cylinder(h=2, d=76);
}

module vetranie1() {
    translate([0,hlbka-35,20]) rotate([0,90,0]) cylinder(h=2, d=20);
    translate([0,hlbka-60,65]) rotate([0,90,0]) cylinder(h=2, d=20);

    translate([0,hlbka-60,30]) rotate([0,90,0]) cylinder(h=2, d=15);
    translate([0,hlbka-30,55]) rotate([0,90,0]) cylinder(h=2, d=15);

    translate([0,hlbka-20,40]) rotate([0,90,0]) cylinder(h=2, d=12);

    translate([0,hlbka-40,72]) rotate([0,90,0]) cylinder(h=2, d=12);
    translate([0,hlbka-40,40]) rotate([0,90,0]) cylinder(h=2, d=10);

    translate([0,hlbka-24,68]) rotate([0,90,0]) cylinder(h=2, d=9);
    translate([0,hlbka-15,24]) rotate([0,90,0]) cylinder(h=2, d=9);

    translate([0,hlbka-45,53]) rotate([0,90,0]) cylinder(h=2, d=7);
    translate([0,hlbka-53,15]) rotate([0,90,0]) cylinder(h=2, d=8);
    translate([0,hlbka-77,45]) rotate([0,90,0]) cylinder(h=2, d=15);
    translate([0,hlbka-57,46]) rotate([0,90,0]) cylinder(h=2, d=10);
    translate([0,hlbka-77,26]) rotate([0,90,0]) cylinder(h=2, d=8);
    translate([0,hlbka-70,12]) rotate([0,90,0]) cylinder(h=2, d=12);
}

module vetranie2() {
    translate([sirka+stena,0,0]) vetranie1();
}

module napajaciKabel() {
    v = 19.6;
    s = 27.6;
    posZ = 51;
    posY = 16.8+stena;
    translate([stena,posY,posZ]) rotate([0,270,0]) cube([v, s,stena]);

    v2 = 23;
    s2 = 31;
    translate([stena-0.5,posY-(s2-s)/2,posZ-(v2-v)/2])     
        rotate([0,270,0]) cube([v2, s2,stena]);

    obluk = 4.3;
    hrana = 10;
    
    echo("------------------------------------");
    echo(v2/2);
    echo(sqrt(2*pow(10,2)));
    echo(sqrt(pow(hrana,2)));
    echo("------------------------------------");
    translate([stena-0.5,posY-(s2-s)/2,posZ+v/2]) 
        rotate([0,270,0]) 
        rotate([0,0,45])
        linear_extrude(height=stena) {
            offset(obluk) square(hrana, center=true);
        }
    translate([stena-0.5,posY+s2-(s2-s)/2,posZ+v/2]) 
        rotate([0,270,0]) 
        rotate([0,0,45])
        linear_extrude(height=stena) {
            offset(obluk) square(hrana, center=true);
        }

    // 3mm srouby - 40mm od seba
    offsetY = (40 - s)/2;
    offsetZ = posZ+v/2;
    translate([0,posY-offsetY,offsetZ]) rotate([0,90,0]) cylinder(h=2, d=3);
    translate([0,s+posY+offsetY,offsetZ]) rotate([0,90,0]) cylinder(h=2, d=3);
}

module switchOnOff() {
    color("red") translate([9,-2,13]) rotate([0,0,0]) cube([11.5, 32, 29.5]);

}

module display() {
    x = 45; 
    y = 45;
    color("black") translate([x,-2,y]) rotate([0,0,0]) cube([45.5, 32, 27.7]);
    
    a = 60;
    b = 30;
    space = 15;
    
    color("red") translate([a,28,b]) rotate([90,0,0]) cylinder(h=30, d=8.5);
    color("black") translate([a+space,28,b]) rotate([90,0,0]) cylinder(h=30, d=8.5);
}

module knob() {
    // 7mm, 25mm
    // 20-25, 46
    v = 65;//43;
    l = 115;
    color("gray") translate([l,28,v]) rotate([90,0,0]) cylinder(h=30, d=8);
    color("gray") translate([l,-1,v]) rotate([90,0,0]) cylinder(h=10, d=25);
}


$fn=30;

module vyrez() {
    posun = 13;
    translate([posun,posun,vyska-stena]) cube([sirka+2*stena-2*posun, hlbka+2*stena-2*posun, 20]);
}

module box() {
    difference() {
        box3();
        switchOnOff();
        display();
        knob();
        holes();
        vyrez();
    }
}

module frontPanel() {
    difference() {
        box();
        translate([0,20,0]) outerBox();
    }
}
//!frontPanel();


module holes(z=origVyska-1, d=3.2) {
    
    // 132 - medzi otvormi
    // 131 na sirku
    odsadenieX = stena+(sirka - 131.5)/2;
    odsadenieY = stena+(hlbka - 132)/2;
    
    color("gray") translate([odsadenieX,odsadenieY,z]) cylinder(h=vyskaAddOn+2*stena, d=d);
    color("gray") translate([sirka+2*stena-odsadenieX,odsadenieY,z]) cylinder(h=vyskaAddOn+2*stena, d=d);

    color("gray") translate([odsadenieX,hlbka+2*stena-odsadenieY,z]) cylinder(h=vyskaAddOn+2*stena, d=d);
    color("gray") translate([sirka+2*stena-odsadenieX,hlbka+2*stena-odsadenieY,z]) cylinder(h=vyskaAddOn+2*stena, d=d);
}

module topPanelsMultikonektorom() {
    // 27, 76.2, 83.8, 3, 6, 
    konektorSirka = 76.2;
    konektorHlbka = 27;
    rozpatieSrouby = 83.8;
    difference() {
        union() {
            topPanel();
            translate([(sirka-konektorSirka)/2+stena-10,35,0]) cube([konektorSirka+20,konektorHlbka+10,4]);
        }
        translate([(sirka-konektorSirka)/2+stena,40,0]) cube([konektorSirka,konektorHlbka,5]);
        
        translate([(sirka-rozpatieSrouby)/2+stena,40+konektorHlbka/2,0]) cylinder(h=4, d1=3, d2=6, center=false);
        translate([sirka-(sirka-rozpatieSrouby)/2+stena,40+konektorHlbka/2,0]) cylinder(h=4, d1=3, d2=6, center=false);
    }
}

module topPanel() {
    // 2 hlavicka vyska, 5.6 hlavicka priemer
    rafik=15;
    resize([0,0,0]) difference() {
        outerBox();
        translate([0,0,4]) outerBox();
        holes(0);
        holes(2,5.7);
        translate([stena+rafik,stena+rafik,2]) cube([sirka-2*rafik,hlbka-2*rafik,5]);        
    }
}

!topPanelsMultikonektorom();

module testKonektorZdroja() {
    intersection() {
        translate([0,0,45]) cube([2,65,35]);
        box();
    }
}

//!testKonektorZdroja();

box();
switchOnOff();
display();
knob();






