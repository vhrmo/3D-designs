
hrubkaVrstvy = 0.28;

sirka = 30;
vyska = 101;
hrubka = 12*hrubkaVrstvy;

hrubkaZadnaStena = 6*hrubkaVrstvy;
hrubkaVyrezPreObrazok = 2*hrubkaVrstvy;

sirkaListaStred = 10;

// kolko pridat na kazdej strane na vysku (extra k vyske obrazku)
vyskaExtra = 2;
prekrytieObrazku = 5;

// pocet trnov na upevnenie obrazku
pocetTrnov = 4;



module baseFrame() {
    difference() {
        cube([sirka, vyska+2*vyskaExtra, hrubka]);
        
        translate([0,vyskaExtra+prekrytieObrazku,hrubkaZadnaStena]) cube([sirka, vyska-2*prekrytieObrazku, hrubka]);
        
        translate([sirka/2+sirkaListaStred/2,vyskaExtra+prekrytieObrazku+5,0]) cube([sirka, vyska-2*prekrytieObrazku-10, hrubka]);

        translate([-sirka/2-sirkaListaStred/2,vyskaExtra+prekrytieObrazku+5,0]) cube([sirka, vyska-2*prekrytieObrazku-10, hrubka]);
        
        translate([0,vyskaExtra,hrubkaZadnaStena]) cube([sirka, vyska, hrubkaVyrezPreObrazok]);
        
    }
}

$fn = 14;

union() {
    baseFrame();
    
    rozpatie = sirka/pocetTrnov;
    
    for (i = [0:1:pocetTrnov-1]) {
    #translate([i*rozpatie+rozpatie/2,vyskaExtra+1.5,hrubkaZadnaStena]) rotate([-90,0,0]) cylinder(h=3, d1=0.8, d2=0.01);
    }

    for (i = [0:1:pocetTrnov-1]) {
     #translate([i*rozpatie+rozpatie/2,vyska+vyskaExtra-1.5,hrubkaZadnaStena]) rotate([90,0,0]) cylinder(h=3, d1=0.8, d2=0.01);
    }
}











