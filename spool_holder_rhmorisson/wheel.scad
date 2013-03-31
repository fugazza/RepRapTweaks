// wheel for supporting the spool on spool holder
// use parameters to adapt it to your spool

spoolDia      = 52;   //mm - diameter of spool hole
wheelSlope    = 20;   //degrees - slope of wheel outer ring
wheelHeight   = 15;   //mm - height of wheel
outerOverhang =  5;   //mm - how much of wheel will be out of spool 
ring_wall     =  4;   //mm - thickness of wall of outer ring
rib_wall      =  2.5; //mm - thickness of ribs and wall around bearing
numberOfRibs  =  5;   // count - number of ribs

bearing_dout = 22.5;  //mm - outer diameter of 608
bearing_din  = 9;     //mm - inner diameter of 608
bearing_b    = 8;     //mm - width of 608

// calculated variables
big_rad = spoolDia/2 + outerOverhang*tan(wheelSlope); // big radius of wheel
small_rad = big_rad - wheelHeight*tan(wheelSlope);// small radius of wheel

// print calculated values
echo(str("original slope = ",atan((60-50)/2/15)," degrees"));
echo(str("big diameter = ",2*big_rad," mm"));
echo(str("small diameter = ",2*small_rad," mm"));

// module for generating parametric wheel
module wheel() {
	difference() {

		// outer shape
		union() {

			// outer ring
			difference() {
				cylinder(h=wheelHeight, r1=small_rad, r2=big_rad, $fn=4*big_rad);
				translate([0,0,-1]) cylinder(h=wheelHeight+2, r1=small_rad-ring_wall-1*tan(wheelSlope), r2=big_rad-ring_wall+1*tan(wheelSlope), $fn=4*small_rad);
			}

			// hub
			cylinder(h=wheelHeight, r=bearing_dout/2+rib_wall, $fn=4*bearing_dout);

			// ribs
			for(i= [0:numberOfRibs-1]) {
				rotate([0,0,i*360/numberOfRibs])
				difference() {
					translate([0,-rib_wall/2,0]) cube([big_rad,rib_wall,wheelHeight]);
					translate([small_rad-ring_wall,-rib_wall/2-1,0]) rotate([0,wheelSlope,0]) cube([wheelHeight,rib_wall+2,(wheelHeight+2)/cos(wheelSlope)]);
				}
			}
		}

		// hole through and hole for bearing
		translate([0,0,-1]) cylinder(h=wheelHeight+2, r=bearing_din/2);
		translate([0,0,wheelHeight-bearing_b]) cylinder(h=bearing_b+1, r=bearing_dout/2);
	}
}

// generate wheel
wheel();