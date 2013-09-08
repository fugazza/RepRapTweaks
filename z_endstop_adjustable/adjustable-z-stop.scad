/*
Adjustable z endstop for Prusa Mendel
by kwixson

trapezoidNut from http://www.thingiverse.com/thing:8793
*/

xend_height=16;
wall_thickness=3.5;
extension=14;

plunger_dia=23;
plunger_height=5;

clip_width=15;
clip_depth=15;

hand_width=12;
hand_length=12;
hand_height=12;

nut_height=2.54;
nut_dia=6.5;

screw_dia=3.6;

$fn=15;

module trapezoidNut(
	length=45,			// axial length of the threaded rod
	radius=25,			// outer radius of the nut
	pitch=10,				// axial distance from crest to crest
	pitchRadius=10,		// radial distance from center to mid-profile
	threadHeightToPitch=0.5,	// ratio between the height of the profile and the pitch
						// std value for Acme or metric lead screw is 0.5
	profileRatio=0.5,		// ratio between the lengths of the raised part of the profile and the pitch
						// std value for Acme or metric lead screw is 0.5
	threadAngle=30,		// angle between the two faces of the thread
						// std value for Acme is 29 or for metric lead screw is 30
	RH=true,				// true/false the thread winds clockwise looking along shaft, i.e.follows the Right Hand Rule
	countersunk=0,			// depth of 45 degree chamfered entries, normalized to pitch
	clearance=0.1,			// radial clearance, normalized to thread height
	backlash=0.1,			// axial clearance, normalized to pitch
	stepsPerTurn=24			// number of slices to create per turn
		)
{
	difference() 
	{
		cylinder(
			h=length,
			r1=radius, 
			r2=radius,
			$fn=6
				);
		
		trapezoidThreadNegativeSpace(
			length=length, 					// axial length of the threaded rod 
			pitch=pitch, 					// axial distance from crest to crest
			pitchRadius=pitchRadius, 			// radial distance from center to mid-profile
			threadHeightToPitch=threadHeightToPitch, 	// ratio between the height of the profile and the pitch 
										// std value for Acme or metric lead screw is 0.5
			profileRatio=profileRatio, 			// ratio between the lengths of the raised part of the profile and the pitch
										// std value for Acme or metric lead screw is 0.5
			threadAngle=threadAngle,			// angle between the two faces of the thread
										// std value for Acme is 29 or for metric lead screw is 30
			RH=true, 						// true/false the thread winds clockwise looking along shaft
										// i.e.follows  Right Hand Rule
			countersunk=countersunk,			// depth of 45 degree countersunk entries, normalized to pitch
			clearance=clearance, 				// radial clearance, normalized to thread height
			backlash=backlash, 				// axial clearance, normalized to pitch
			stepsPerTurn=stepsPerTurn 			// number of slices to create per turn
				);	
	}
}

rotate([90,0,0]){
	translate([0,0,-(xend_height/2+wall_thickness)]){
		union(){
			//clip
			difference(){
				union(){
					cube([clip_width,clip_depth+wall_thickness,xend_height+wall_thickness*2]);
					translate([0,0,-wall_thickness]) cube([clip_width,clip_depth+wall_thickness,wall_thickness+.5]);
				}
				# translate([-1,wall_thickness,wall_thickness]) cube([clip_width+2,clip_depth+1,xend_height+.2]);
				# translate([clip_width/2,wall_thickness+clip_depth/2,wall_thickness+1]) {
					rotate([0,180,0]){
						union(){
							trapezoidNut(nut_height+1,nut_dia/2);
							cylinder(h=wall_thickness*2+2,r=screw_dia/2);
						}
					}
				}
			}
			//extension
			translate([0-extension+.01,0,-wall_thickness]) cube([extension+.01,wall_thickness,hand_height]);
			//hand
			translate([0-extension+.01-hand_width,0,-wall_thickness]){
				difference(){
					cube([hand_width,hand_length+wall_thickness,hand_height]);
					# translate([hand_width/2,hand_length/2+wall_thickness,0]) {
						union(){
							translate([0,0,-1]) trapezoidNut(nut_height+1,nut_dia/2);
							cylinder(h=hand_height+2,r=screw_dia/2);
						}
					}
				}
			}
		}
	}
}

//plunger
translate([30,0,plunger_height]){
	rotate([180,0,0]){
		difference(){
			cylinder(h=plunger_height,r=plunger_dia/2);
			# translate([0,0,0]) {
				union(){
					translate([0,0,-1]) trapezoidNut(nut_height+1,nut_dia/2);
					cylinder(h=hand_height+2,r=screw_dia/2);
				}
			}
		}
	}
}