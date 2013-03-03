// Mendel Filament Holder V2
//
//   based on the Mendel Filament Guide
// 
// Author: Robert H. Morrison
// Date..: 29 April 2012
//
// License GNU GPL v2 or newer.

M3=4.02; 
M8=8.05;

vertex_height=30;
filament_roll_r=150;

FN=80;

module filament_guide(side) { 
	translate([0,side*10,0]) rotate([90+90*side,0,0]) difference()
	{
		union() {
			translate ([17.25295,-55,0])
				rotate([0,0,60.0])
					difference() 
			{
				union () {
					linear_extrude(file = "vertex-body-fixed-qcad.dxf",
						height=vertex_height,center=true);
				}
			
				translate([11.013,59.912]) zhole(M8); 
				translate([40.274,9.249,0]) zhole(M8); 
			}
			cylinder(h=60,r=8,center=true,$fn=FN);
		}
	
		translate([0,0,58]) zhole(M8);
		translate([0,0,-58]) zhole(M8);
	
		translate([0,0,side*25]) cube([100,100,50], true);
	
		translate([-2,-39.275,12.5])
			rotate([0,0,-60])
				cube([50,50,100], true);
	
		translate([-32,19.65,12.5])
			rotate([0,0,-60])
				cube([50,50,100], true);
	
		translate([32,19.65,12.5])
			rotate([0,0,60])
				cube([50,50,100], true);
	
		translate([12.75,-22,12.5])
			rotate([0,0,60])
				cube([28,28,100], true);
	
		translate([28,-28,12])
			rotate([0,0,60])
				cube([12,12,100], true);
	
		translate([-22,-11.4,12.5])
			rotate([0,0,-60])
				cube([8,16,100], true);
	
		translate([-15,-12,12.5])
			rotate([0,0,30])
				cube([8,16,100], true);
	
		translate([-9,-17.19,12.5])
			rotate([0,0,-20])
				cube([22,22,100], true);
	
		translate([-15.5,-17.19,12.5])
			rotate([0,0,25])
				cube([12,12,100], true);
	}
}

module zhole(diameter) cylinder(h=100,r=(diameter/2),center=true,$fn=FN); 

module zteardrop(diameter,height)
{
	rotate([0,0,45]) {
		union() {
			translate([0,0,-height/2]) {
				cube([diameter/2,diameter/2,height], false);
			}
			cylinder(r = diameter/2, h = height, center=true);
		}
	}
} 

module MendelFilamentHolder(side)
{
	translate([0,0,vertex_height/4-side*(vertex_height/4)]) rotate([90-90*side,0,0]) {
		translate([-filament_roll_r+20,filament_roll_r-20,vertex_height/4])
		%	cylinder(h=vertex_height/4, r=filament_roll_r, center=true);
		
		// lower strut
		translate([-filament_roll_r-32,-15,vertex_height/4])
			difference() {
				cylinder(h=vertex_height/2, r=filament_roll_r, center=true, $fn=200);
				cylinder(h=vertex_height/2+1, r=filament_roll_r-8, center=true, $fn=200);
				translate([-filament_roll_r+48,0])
					cube([300, 300, vertex_height/2+1], true);
				translate([110,-192,0])
					rotate([0,0,30])
						cube([300, 300, vertex_height/2+1], true);
			}
		
		// upper strut
		translate([-filament_roll_r+26,-10,vertex_height/4])
			difference() {
				cylinder(h=vertex_height/2, r=filament_roll_r-10, center=true, $fn=200);
				cylinder(h=vertex_height/2+1, r=filament_roll_r-18, center=true, $fn=200);
				translate([-filament_roll_r-2,0,0])
					cube([300, 300, vertex_height/2+1], true);
				translate([144,-167,0])
					rotate([0,0,-30])
						cube([300, 300, vertex_height/2+1], true);
			}
		
		// upper/lower connector w/RepRap LOGO
		translate([-filament_roll_r/2+26,filament_roll_r/2+3,vertex_height/4])
			difference() {
				cylinder(h=vertex_height/2, r=20, center=true, $fn=100);
				zteardrop(20,vertex_height/2+1);
			}
		
		// filament spool rod holder
		translate([-filament_roll_r+20,filament_roll_r-20,vertex_height/4])
			difference() {
				cylinder(h=vertex_height/2, r=12, center=true);
				cylinder(h=vertex_height/2+1, r=4.1, center=true);
				translate([0,50,0])
					cube([8.2,100,vertex_height/2+1,], center=true);
			}
	}

	rotate([0,0,180])
		translate([0,-10*side,0])
			filament_guide(side);
}

//---------------------------------------
//	Change the parameter to select if
// you want to create the
//	LEFT or RIGHT side filament holder.
//---------------------------------------
//	-1 for LEFT, 1 for RIGHT

MendelFilamentHolder(1);
