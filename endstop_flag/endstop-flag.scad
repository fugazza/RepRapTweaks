module endstop_flag() {

	difference () {
		cube(size = [20,15,10], center = false);
		translate(v = [5,3,-5]) cube(20,15,20);
		translate ([-1,9,5]) rotate([0,90,0]) cylinder(h=20, r=3.1/2/cos(30),$fn = 12);
		translate ([2.5,9,5]) rotate(a=[90,0,90]) cylinder(h=20, r=5.5/2/cos(30),$fn = 6);
	}
}

endstop_flag();