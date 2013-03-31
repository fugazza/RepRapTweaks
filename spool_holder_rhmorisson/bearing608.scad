// printed replacement for 608 bearing
// does not have parameters of real 608 bearing!!!

bearing_dout = 22;  //mm - outer diameter of 608
bearing_din  = 8;   //mm - inner diameter of 608
bearing_b    = 7;   //mm - width of 608

module bearing608() {
	difference() {
		cylinder(h=bearing_b, r=bearing_dout/2);
		translate([0,0,-1]) cylinder(h=bearing_b+2, r=bearing_din/2/cos(360/(2*bearing_din)/2), $fn=2*bearing_din);
	}
}

bearing608();