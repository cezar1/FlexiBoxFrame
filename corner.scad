include <main.scad>;

CORNER_LENGTH=PITCH1*1.5;
CORNER_THICK=1.2;
CORNER_HEIGHT_ADD=0.1;

module corner()
{
    //Side plate
    difference()
    {
        translate([0,-CORNER_THICK/2-BASE_THICKNESS/2-CORNER_HEIGHT_ADD/2,0]) color([1,0,0]) cube([CORNER_LENGTH,CORNER_THICK-CORNER_HEIGHT_ADD,BASE_HEIGHT+CORNER_HEIGHT_ADD],center=true);
        translate([0,-CORNER_THICK-CORNER_HEIGHT_ADD-BASE_THICKNESS/2,0]) rotate([90,0,0])hex_hole(h_trap=0,h_hole=CORNER_THICK+0.1,r_trap=SCREWSTANDARD_M3,rot=180);
        
    }
    
difference()
{
    union()
    {
        //Top plate
        translate([0,-CORNER_THICK/2,BASE_HEIGHT/2+CORNER_THICK/2+CORNER_HEIGHT_ADD/2]) color([1,0,0]) cube([CORNER_LENGTH,BASE_THICKNESS+CORNER_THICK,CORNER_THICK],center=true);
        //Bottom plate
        translate([0,-CORNER_THICK/2,-(BASE_HEIGHT/2+CORNER_THICK/2+CORNER_HEIGHT_ADD/2)]) color([1,0,0]) cube([CORNER_LENGTH,BASE_THICKNESS+CORNER_THICK,CORNER_THICK],center=true);
    }
    union()
    {
        //PITCH1 holes
        for(i=[-1,1])
        {
        color([0,0,1]) translate([i*PITCH1/2,0,BASE_HEIGHT/2+CORNER_THICK+CORNER_HEIGHT_ADD/2+0.05]) hex_hole(h_trap=0,h_hole=CORNER_THICK+0.1,r_trap=SCREWSTANDARD_M3,rot=180);
        color([0,0,1]) translate([i*PITCH1/2,0,-(BASE_HEIGHT/2+CORNER_HEIGHT_ADD/2-0.05)]) hex_hole(h_trap=0,h_hole=CORNER_THICK+0.1,r_trap=SCREWSTANDARD_M3,rot=180);    
        }
    }
}

}

//beam(length=200,width=BASE_THICKNESS,height=BASE_HEIGHT,holes1=1,holes2=1);
rotate([90,0,0]) corner();




