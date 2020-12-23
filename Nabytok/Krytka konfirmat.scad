

$fn=32;

module krytka(priemer = 11, velkost_pin = 4.5, vyska = 2.5) {
    cylinder(h = vyska, d = velkost_pin, $fn = 6);
    cylinder(h = 0.2, d = priemer);
}

translate([0,0,0]) krytka(priemer = 11, velkost_pin = 4.5, vyska = 2.5);
translate([15,0,0]) krytka(priemer = 11, velkost_pin = 4.75, vyska = 3);
translate([30,0,0]) krytka(priemer = 11, velkost_pin = 5, vyska = 3);
