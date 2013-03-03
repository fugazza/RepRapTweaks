module ramps_holder_2(){
m8_diameter = 8;
m3_diameter = 3.2;
m3_nut_diameter = 5.8 / cos(30);
m3_nut_outer_dia = 11.54;
outer_diameter = m8_diameter/2+3.3;
first_hole_position = 20;
opening_size = m8_diameter-1.5; //openingsize

difference(){
	union(){


		translate([outer_diameter, outer_diameter, 0]) cylinder(h =10, r = outer_diameter, $fn = 20);
		translate([outer_diameter, 0, 0]) cube([15.5,outer_diameter*2,10]);
		
		//standoffs
		translate([-first_hole_position-3, -3, 0]) cube([6,5,10]);
		
		translate([-(first_hole_position + m3_nut_outer_dia/2), 0, 0]) cube([m3_nut_outer_dia+first_hole_position+15, 4, 10]);
		translate([17, 17.5, 5]) rotate([90, 0, 0]) cylinder(h =5, r = 5.77, $fn = 6);
		
		
		translate([-first_hole_position, 0,0]) translate([0, 7, 5]) rotate([90, 0, 0]) #cylinder(h =5, r = m3_nut_outer_dia/2, $fn = 6);
		
	}

	translate([9, outer_diameter-opening_size/2, -1]) cube([18,opening_size,20]);
	translate([outer_diameter, outer_diameter, -1]) cylinder(h =20, r = m8_diameter/2, $fn = 18);

	//Securing hole
	translate([17, 17, 5]) rotate([90, 0, 0]) cylinder(h =20, r = m3_diameter/2, $fn = 10);
	translate([17, 19.5, 5]) rotate([90, 0, 0]) #cylinder(h =5, r = m3_nut_diameter/2, $fn = 6);

	translate([17, 17, 5]) rotate([90, 0, 0]) #cylinder(h =20, r = m3_diameter/2, $fn = 10);
	translate([-first_hole_position, 16, 5]) rotate([90, 0, 0]) cylinder(h =20, r = m3_diameter/2, $fn = 10);
	
	translate([-first_hole_position, 9, 5]) rotate([90, 0, 0]) #cylinder(h =5, r = m3_nut_diameter/2, $fn = 6);
}
}
ramps_holder_2();

