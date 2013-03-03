module fillet(radius, length) {
	difference() {
		translate([radius, radius, 0]) cube([2*radius, 2*radius, length], center = true);
		cylinder(h = length + 2, r = radius, center = true, $fn=18);
	}
}

module vnejsi_tvar() {
	difference () {
		cube ([12,13,7]);
		translate([1.5,1.5,5]) rotate([0,0,180]) fillet(1.5,12);
		translate([1.5,11.5,5]) rotate([0,0,90]) fillet(1.5,12);
		translate([10.5,11.5,5]) rotate([0,0,0]) fillet(1.5,12);
		translate([10.5,1.5,5]) rotate([0,0,-90]) fillet(1.5,12);
	}
}

module vnitrni_tvar() {
	translate([8,-1,-1]) difference() {
		cube ([2.5,11,10]);
		translate([2.5,2,-1]) cylinder(h=12, r = 1, $fn = 12);
		translate([0,2,-1]) cylinder(h=12, r = 1, $fn = 12);
		translate([1,10,5]) rotate([0,0,90]) fillet(1,12);
		translate([1.5,10,5]) rotate([0,0,0]) fillet(1,12);
	}
}

color("Khaki")
difference () {
	vnejsi_tvar();
	translate([2,-1,-1]) cube([4,11,10]);
	vnitrni_tvar();
}