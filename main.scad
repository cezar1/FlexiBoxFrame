include <hex_trap.scad>;
use <joiner.scad>;
TOWER_LENGTH=200;
TOWER_WIDTH=140;
TOWER_HEIGHT=100;
BASE_THICKNESS=8;
BASE_HEIGHT=8;
SCREWSTANDARD_M3=3;
NUTHEIGHT_M3=2.4;
SCREW_SIZE1=16;
HOLE_PAD=2.5;
CONFIG_ALL=0;
CONFIG_SIDE_BEAMS_ONLY=1;
CONFIG_BOTTOM_LEGS=2;
PITCH1=20;
EXPLODED=0;
STRUT_VERTICAL_HEIGHT=2;
STRUT1_HEIGHT=3;

MITY_BEAM_THICKNESS=3;
MITY_BEAM_TRAP_PART=4;
MITY_LIFT_PCB=4;
MITY_PCB_THICKNESS=2;
MITY_DIFF1=15;
MITY_START1=-47.5;
MITY_START1_Y=-5;
MITY_DIFF2=10;//Vertical difference between groups
MITY_DIFF3=70;//Length of the four hole groups

PINE64_LIFT_PCB=1.5;
PINE64_BLOCK_EXTRA=1;
PINE64_BEAM_HEIGHT=3.3;

LEG_INTERFACE_THICKNESS=2;
EXTRA_LEG_WIDTH=30;

WALL_BASE_THICKNESS=1.2;
WALL_MOUNT_THICKNESS=3;
WALL_MOUNT_WIDTH=BASE_THICKNESS;
FAN_HOLES_DIST=82.5;
FAN_LINING_WIDTH=2;
FAN_ZIP_TIE_DIST=3;
FAN_ZIP_TIE_L1=1.5;
FAN_ZIP_TIE_L2=4.75;
ZIP_TIE_H=3;
FAN_CABLE_CUTOUT_RAD=8;
FAN_CABLE_FROM_TOP_BOTTOM=10;
FAN_CABLE_FROM_LEFT_RIGHT=4;

module tower_wall_mount(block,hole)
{
    temp=WALL_MOUNT_THICKNESS/2-WALL_BASE_THICKNESS/2;
    if (block==true)
    {
        translate([0,0,temp]) cube([WALL_MOUNT_WIDTH,WALL_MOUNT_WIDTH,WALL_MOUNT_THICKNESS],center=true);
    }
    if (hole==true)
    {
        translate([0,0,-0.05-WALL_MOUNT_THICKNESS/2+temp]) color([0,1,0])
        hex_hole(h_trap=WALL_MOUNT_THICKNESS/2,h_hole=WALL_MOUNT_THICKNESS/2+0.1,r_trap=SCREWSTANDARD_M3,rot=0);
    }
}
module tower_wall_fan_mount(block,hole)
{
    temp=WALL_MOUNT_THICKNESS/2-WALL_BASE_THICKNESS/2;
    if (block==true)
    {
        translate([0,0,temp]) cube([WALL_MOUNT_WIDTH,WALL_MOUNT_WIDTH,WALL_MOUNT_THICKNESS],center=true);
    }
    if (hole==true)
    {
        translate([0,0,+0.05+WALL_MOUNT_THICKNESS/2+temp]) color([0,1,0]) hex_hole(h_trap=WALL_MOUNT_THICKNESS/2,h_hole=WALL_MOUNT_THICKNESS/2+0.1,r_trap=SCREWSTANDARD_M3,rot=180);
    }
}
module tower_wall_front_rear()
{
    cube([TOWER_HEIGHT+BASE_THICKNESS*2,TOWER_WIDTH+BASE_THICKNESS,WALL_BASE_THICKNESS],center=true);
}
module fan_cutout(ziptieN,ziptieS,ziptieW,ziptieE)
{
    cylinder(h=WALL_BASE_THICKNESS,r=FAN_CABLE_CUTOUT_RAD,center=true);
    if (ziptieN==true)
    {
        translate([-(FAN_CABLE_CUTOUT_RAD+FAN_ZIP_TIE_DIST),0,0]) cube([FAN_ZIP_TIE_L1,FAN_ZIP_TIE_L2,WALL_BASE_THICKNESS+0.1],center=true);
    }
    if (ziptieS==true)
    {
        translate([(FAN_CABLE_CUTOUT_RAD+FAN_ZIP_TIE_DIST),0,0]) cube([FAN_ZIP_TIE_L1,FAN_ZIP_TIE_L2,WALL_BASE_THICKNESS+0.1],center=true);
    }
    if (ziptieW==true)
    {
        translate([0,-(FAN_CABLE_CUTOUT_RAD+FAN_ZIP_TIE_DIST),0]) cube([FAN_ZIP_TIE_L2,FAN_ZIP_TIE_L1,WALL_BASE_THICKNESS+0.1],center=true);
    }
    if (ziptieE==true)
    {
        translate([0,(FAN_CABLE_CUTOUT_RAD+FAN_ZIP_TIE_DIST),0]) cube([FAN_ZIP_TIE_L2,FAN_ZIP_TIE_L1,WALL_BASE_THICKNESS+0.1],center=true);
    }
}
module tower_panel_fan()
{
    local_height=TOWER_HEIGHT+BASE_THICKNESS*2;
    difference()
    {
        union()
        {
            //Main panel
            color([1,0,0])tower_wall_front_rear();
            //Wall mounting blocks
            for (j=[1,-1]){
                for (i=[2,1,-1,-2]){
                    translate([j*(TOWER_HEIGHT/2+BASE_THICKNESS/2),i*PITCH1,0])tower_wall_mount(block=true);
                }
            }
            //Fan fixing blocks
            for (j=[1,-1]){
                for (i=[1,-1]){
                    translate([j*FAN_HOLES_DIST/2,i*FAN_HOLES_DIST/2,0])tower_wall_fan_mount(block=true);
                }
            }
            //Fan lining
            lining_thickness=WALL_MOUNT_THICKNESS-WALL_BASE_THICKNESS;
            for (j=[1,-1]){
                translate([j*(FAN_HOLES_DIST/2+WALL_MOUNT_WIDTH/2-FAN_LINING_WIDTH/2),0,WALL_BASE_THICKNESS/2+lining_thickness/2])cube([FAN_LINING_WIDTH,FAN_HOLES_DIST-WALL_MOUNT_WIDTH,lining_thickness],center=true);
            }
            for (j=[1,-1]){
                translate([0,j*(FAN_HOLES_DIST/2+WALL_MOUNT_WIDTH/2-FAN_LINING_WIDTH/2),WALL_BASE_THICKNESS/2+lining_thickness/2])cube([FAN_HOLES_DIST-WALL_MOUNT_WIDTH,FAN_LINING_WIDTH,lining_thickness],center=true);
            }
        }
        union()
        {
            //Main fain cutout
            cube([FAN_HOLES_DIST-WALL_MOUNT_WIDTH,FAN_HOLES_DIST-WALL_MOUNT_WIDTH,WALL_BASE_THICKNESS+0.1],center=true);
            cylinder(r=FAN_HOLES_DIST/2+2,h=WALL_BASE_THICKNESS+0.1,center=true);
            //Wall mounting blocks
            for (j=[1,-1]){
                for (i=[2,1,-1,-2]){
                    translate([j*(TOWER_HEIGHT/2+BASE_THICKNESS/2),i*PITCH1,0])tower_wall_mount(hole=true);
                }
            }
            //Fan fixing blocks
            for (j=[1,-1]){
                for (i=[1,-1]){
                    translate([j*FAN_HOLES_DIST/2,i*FAN_HOLES_DIST/2,0])tower_wall_fan_mount(hole=true);
                }
            }
            //Cable cutouts
            for (i=[1,-1]){
                for (j=[1,-1]){
                translate([j*(local_height/2-FAN_CABLE_CUTOUT_RAD-FAN_CABLE_FROM_TOP_BOTTOM),i*(TOWER_WIDTH/2-FAN_CABLE_CUTOUT_RAD-FAN_CABLE_FROM_LEFT_RIGHT),0]) fan_cutout(ziptieN=(j==1),ziptieS=(j==-1),ziptieW=(i==1),ziptieE=(i==-1));
                translate([0,i*(TOWER_WIDTH/2-FAN_CABLE_CUTOUT_RAD-FAN_CABLE_FROM_LEFT_RIGHT),0]) fan_cutout(ziptieN=true,ziptieS=true,ziptieW=(i==1),ziptieE=(i==-1));
                
                }
                
            }
        }
    }
    
    
    
    
}

module tower_wall_assembly()
{
    translate([TOWER_LENGTH/2+BASE_THICKNESS/2+WALL_BASE_THICKNESS/2,0,0]) rotate([0,90,0])tower_panel_fan();
}

module pine64_beam_support_block_only(x,y)
{
    

    translate([x,y,0])
        
            
    
                
                
                translate([0,0,0]) cube([BASE_HEIGHT+PINE64_BLOCK_EXTRA,BASE_HEIGHT+PINE64_BLOCK_EXTRA,BASE_HEIGHT],center=true);
            
        
    
}
module pine64_beam_support(x,y)
{
    
    //temp_nutheight=0;
    temp_nutheight=BASE_HEIGHT/2;
    sink=10-(NUTHEIGHT_M3-PINE64_LIFT_PCB);
    
    translate([x,y,0]){
        difference(){
            union(){
    
                
                
                translate([0,0,-BASE_HEIGHT/2+PINE64_BEAM_HEIGHT/2]) cube([BASE_HEIGHT+PINE64_BLOCK_EXTRA,BASE_HEIGHT+PINE64_BLOCK_EXTRA,PINE64_BEAM_HEIGHT],center=true);}
            union(){
                translate([0,0,-BASE_HEIGHT/2+PINE64_BEAM_HEIGHT+0.1]) color([0,1,0])hex_hole(h_trap=NUTHEIGHT_M3,h_hole=PINE64_BEAM_HEIGHT-NUTHEIGHT_M3+0.2,r_trap=SCREWSTANDARD_M3,rot=180);
                
            }
        }
        
    }
}

module mity_beam_support(x,y)
{
    
    //temp_nutheight=0;
    temp_nutheight=BASE_HEIGHT;
    translate([x,y,0]){
        difference(){
            union(){
    
                
                translate([0,0,BASE_HEIGHT/2+MITY_LIFT_PCB/2]) cylinder(r=SCREWSTANDARD_M3*1.5,h=MITY_LIFT_PCB,center=true);
                translate([0,0,0]) cube([BASE_HEIGHT,BASE_HEIGHT,BASE_HEIGHT],center=true);}
            union(){
                translate([0,0,SCREW_SIZE1-BASE_HEIGHT/2-0.1]) color([0,1,0])hex_hole(h_trap=temp_nutheight,h_hole=SCREW_SIZE1-temp_nutheight,r_trap=SCREWSTANDARD_M3,rot=180);
                translate([0,0,12-BASE_HEIGHT/2+0.1]) color([0,1,0])hex_hole(h_trap=NUTHEIGHT_M3,h_hole=0,r_trap=SCREWSTANDARD_M3,rot=180);
            }
        }
    }
}
module pine64_beam_fixer(shift)
{
    
    difference(){
            translate([0,shift,0]) cube([MITY_BEAM_TRAP_PART,PITCH1*1.5,BASE_HEIGHT],center=true);
            union(){
                for(i=[-1,0,1]) {
                    translate([MITY_BEAM_TRAP_PART/2+0.1,i*PITCH1,0]) rotate([0,90,0]) color([0,1,0]) hex_hole(h_trap=NUTHEIGHT_M3,h_hole=MITY_BEAM_TRAP_PART-NUTHEIGHT_M3+0.2,r_trap=SCREWSTANDARD_M3,rot=180);
                }
            }
            
        }
}
module mity_beam_fixer()
{
    
    difference(){
            cube([MITY_BEAM_TRAP_PART,PITCH1*2.5,BASE_HEIGHT],center=true);
            union(){
                for(i=[-1,1]) {
                    translate([MITY_BEAM_TRAP_PART/2+0.1,i*PITCH1,0]) rotate([0,90,0]) color([0,1,0]) hex_hole(h_trap=NUTHEIGHT_M3,h_hole=MITY_BEAM_TRAP_PART-NUTHEIGHT_M3+0.2,r_trap=SCREWSTANDARD_M3,rot=180);
                }
            }
            
        }
}
module mity_beam(length,x1,y1,x2,y2,x3,y3,x4,y4)
{
    mity_beam_support(x=x1,y=y1);    
    mity_beam_support(x=x2,y=y2);
    
    if (y1>0)
    {
        translate([x1,y1/2+MITY_BEAM_THICKNESS/4-BASE_THICKNESS/4,0]) color ([0,0,1]) cube([MITY_BEAM_THICKNESS,abs(y1)-BASE_THICKNESS/2-MITY_BEAM_THICKNESS/2,BASE_HEIGHT],center=true);
    }
    else
    {
        translate([x1,-y1/2+MITY_BEAM_THICKNESS/4-BASE_THICKNESS/4,0]) color ([0,0,1]) cube([MITY_BEAM_THICKNESS,abs(y1)-BASE_THICKNESS/2-MITY_BEAM_THICKNESS/2,BASE_HEIGHT],center=true);
    }     
   
    
    if (y2>0)
    {
        translate([x2,-y2/2+MITY_BEAM_THICKNESS/4-BASE_THICKNESS/4,0]) color ([1,0,0]) cube([MITY_BEAM_THICKNESS,abs(y2)-BASE_THICKNESS/2-MITY_BEAM_THICKNESS/2,BASE_HEIGHT],center=true);
    }
    else
    {
        translate([x2,y2/2-MITY_BEAM_THICKNESS/4+BASE_THICKNESS/4,0]) color ([0,1,0]) cube([MITY_BEAM_THICKNESS,abs(y2)-BASE_THICKNESS/2-MITY_BEAM_THICKNESS/2,BASE_HEIGHT],center=true);
    }
    mity_beam_support(x=x3,y=y3);
    mity_beam_support(x=x4,y=y4);
    if (y3>0)
    {
        translate([x3,-y3/2-MITY_BEAM_THICKNESS/4+BASE_THICKNESS/4,0]) color ([1,1,0]) cube([MITY_BEAM_THICKNESS,abs(y3)-BASE_THICKNESS/2-MITY_BEAM_THICKNESS/2,BASE_HEIGHT],center=true);
    }
    else
    {
        translate([x3,y3/2+MITY_BEAM_THICKNESS/4-BASE_THICKNESS/4,0]) color ([1,0,0]) cube([MITY_BEAM_THICKNESS,abs(y3)-BASE_THICKNESS/2-MITY_BEAM_THICKNESS/2,BASE_HEIGHT],center=true);
    }
    translate([x4,y3/2+MITY_BEAM_THICKNESS/4-BASE_THICKNESS/4,0]) cube([MITY_BEAM_THICKNESS,abs(y3)-BASE_THICKNESS/2-MITY_BEAM_THICKNESS/2,BASE_HEIGHT],center=true);
    
    //Main support
    cube([length,MITY_BEAM_THICKNESS,BASE_HEIGHT],center=true);
    
    //Fixers
    translate([length/2-MITY_BEAM_TRAP_PART/2,0,0]) mity_beam_fixer();
    translate([-length/2+MITY_BEAM_TRAP_PART/2,0,0]) mirror([1,0,0]) mity_beam_fixer();    
    
}
module double_beam(length,rect_length,rect_width)
{
    DOUBLE_BEAM_DIST=PITCH1;
    DOUBLE_BEAM_INNER_BRIM=1;
    //translate([0,-10,0])
    {
    difference()
    {
        union()
        {
        for(i=[-1,1]){
            //Main support
            translate([0,i*DOUBLE_BEAM_DIST/2,0]) cube([length,MITY_BEAM_THICKNESS,BASE_HEIGHT],center=true);
            translate([i*DOUBLE_BEAM_DIST/2,0,0]) cube([MITY_BEAM_THICKNESS,rect_length,BASE_HEIGHT],center=true);
            translate([i*rect_width/2,0,DOUBLE_BEAM_INNER_BRIM/2]) cube([MITY_BEAM_THICKNESS,rect_length,BASE_HEIGHT+DOUBLE_BEAM_INNER_BRIM],center=true);
            translate([0,i*rect_length/2,DOUBLE_BEAM_INNER_BRIM/2]) cube([rect_width+MITY_BEAM_THICKNESS,MITY_BEAM_THICKNESS,BASE_HEIGHT+DOUBLE_BEAM_INNER_BRIM],center=true);
            }
        }
        union()
        {
            //Zip ties
            for (i=[-1,1]){
                translate([0,0,-1]){
                //ACROSS ZIPTIES
                translate([i*DOUBLE_BEAM_DIST/2,0,0]) color([1,0,0]) cube([MITY_BEAM_THICKNESS+0.1,FAN_ZIP_TIE_L2,ZIP_TIE_H],center=true);
                translate([i*rect_width/2,0,0]) color([1,0,0]) cube([MITY_BEAM_THICKNESS+0.1,FAN_ZIP_TIE_L2,ZIP_TIE_H],center=true);
                for (j=[-1,1]){
                    translate([i*DOUBLE_BEAM_DIST/2,j*(rect_length/2-10),0]) color([1,0,0]) cube([MITY_BEAM_THICKNESS+0.1,FAN_ZIP_TIE_L2,ZIP_TIE_H],center=true);
                    translate([i*rect_width/2,j*(rect_length/2-10),0]) color([1,0,0]) cube([MITY_BEAM_THICKNESS+0.1,FAN_ZIP_TIE_L2,ZIP_TIE_H],center=true);
                }
                }
                //ALONG ZIPTIES
                translate([0,0,1]){
                translate([0,i*DOUBLE_BEAM_DIST/2,0]) color([1,0,0]) cube([FAN_ZIP_TIE_L2,MITY_BEAM_THICKNESS+0.1,ZIP_TIE_H],center=true);
                translate([0,i*rect_length/2,0]) color([1,0,0]) cube([FAN_ZIP_TIE_L2,MITY_BEAM_THICKNESS+0.1,ZIP_TIE_H],center=true);
                for (j=[-1,1]){
                    translate([j*(rect_width/2-10),i*rect_length/2,0]) color([1,0,0]) cube([FAN_ZIP_TIE_L2,MITY_BEAM_THICKNESS+0.1,ZIP_TIE_H],center=true);
                    translate([j*(rect_width/2-10),i*DOUBLE_BEAM_DIST/2,0]) color([1,0,0]) cube([FAN_ZIP_TIE_L2,MITY_BEAM_THICKNESS+0.1,ZIP_TIE_H],center=true);
                    }
                }
            }    
        }
    }
}
    //Fixers
    translate([length/2-MITY_BEAM_TRAP_PART/2,0,0]) mity_beam_fixer();
    translate([-length/2+MITY_BEAM_TRAP_PART/2,0,0]) mirror([1,0,0]) mity_beam_fixer();    
    
}

module beam_holes1(length,width,height)
{
    for (i=[-1,1]) translate([i*(length/2-HOLE_PAD-SCREWSTANDARD_M3/2),0,0]) {
        color([0,1,0]){
		translate([0,0,SCREW_SIZE1-height/2]) hex_hole(h_trap=NUTHEIGHT_M3+0.1,h_hole=SCREW_SIZE1-NUTHEIGHT_M3,r_trap=SCREWSTANDARD_M3,rot=180);
        }
    }
}
module beam_holes2()
{
    for (i=[-floor((length-PITCH1)/2/PITCH1):1:floor((length-PITCH1)/2/PITCH1)]) color([0,1,0]) translate([i*PITCH1,SCREW_SIZE1-BASE_THICKNESS/2,0]) rotate([-90,0,0]) hex_hole(h_trap=NUTHEIGHT_M3+0.1,h_hole=SCREW_SIZE1-NUTHEIGHT_M3,r_trap=SCREWSTANDARD_M3,rot=180);
    for (i=[-floor((length-PITCH1)/2/PITCH1):1:floor((length-PITCH1)/2/PITCH1)]) color([0,1,0]) translate([i*PITCH1,-SCREW_SIZE1+BASE_THICKNESS/2,0]) rotate([-90,0,180]) hex_hole(h_trap=NUTHEIGHT_M3+0.1,h_hole=SCREW_SIZE1-NUTHEIGHT_M3,r_trap=SCREWSTANDARD_M3,rot=180);
        
    for (i=[-floor((length-PITCH1)/2/PITCH1):1:floor((length-PITCH1*3)/2/PITCH1)]) color([0,1,0]) translate([i*PITCH1+PITCH1/2,0,SCREW_SIZE1-BASE_HEIGHT/2]) rotate([0,0,0]) hex_hole(h_trap=NUTHEIGHT_M3+0.1,h_hole=SCREW_SIZE1-NUTHEIGHT_M3,r_trap=SCREWSTANDARD_M3,rot=180);
    for (i=[-floor((length-PITCH1)/2/PITCH1):1:floor((length-PITCH1*3)/2/PITCH1)]) color([0,1,0]) translate([i*PITCH1+PITCH1/2,0,-SCREW_SIZE1+BASE_HEIGHT/2]) rotate([0,180,0]) hex_hole(h_trap=NUTHEIGHT_M3+0.1,h_hole=SCREW_SIZE1-NUTHEIGHT_M3,r_trap=SCREWSTANDARD_M3,rot=180);
        
}
module beam_side_traps()
{
    color([1,0,0]) rotate([0,90,0]) hex_hole_exit(h_trap=NUTHEIGHT_M3,h_hole=SCREW_SIZE1-NUTHEIGHT_M3,r_trap=SCREWSTANDARD_M3,rot=0,l_exit=20,rot_exit=-180);
    color([1,0,0]) translate([10,0,0]) rotate([0,90,0]) hex_hole_exit(h_trap=0,h_hole=SCREW_SIZE1-NUTHEIGHT_M3,r_trap=SCREWSTANDARD_M3,rot=0,l_exit=20,rot_exit=-180);
}
module beam_struts1()
{
    
    local_height2=BASE_THICKNESS-STRUT_VERTICAL_HEIGHT*2;
    translate([length/2+BASE_THICKNESS/2-inside,0,+local_height2/2-BASE_THICKNESS/2]) color([0,0,1]) cube([BASE_THICKNESS,BASE_THICKNESS,local_height2],center=true);
    translate([-length/2-BASE_THICKNESS/2+inside,0,+local_height2/2-BASE_THICKNESS/2]) color([0,0,1]) cube([BASE_THICKNESS,BASE_THICKNESS,local_height2],center=true);
}
module beam_struts2()
{
    local_height2=STRUT_VERTICAL_HEIGHT;
    translate([length/2+BASE_THICKNESS/2-inside,BASE_THICKNESS/4,-local_height2/2+BASE_THICKNESS/2]) color([1,0,1]) cube([BASE_THICKNESS,BASE_THICKNESS/2,local_height2],center=true);
    translate([-length/2-BASE_THICKNESS/2+inside,BASE_THICKNESS/4,-local_height2/2+BASE_THICKNESS/2]) color([1,0,1]) cube([BASE_THICKNESS,BASE_THICKNESS/2,local_height2],center=true);
    //translate([-length/2-BASE_THICKNESS/2+inside,0,+local_height2/2-BASE_THICKNESS/2]) color([0,0,1]) cube([BASE_THICKNESS,BASE_THICKNESS,local_height2],center=true);
}
module beam_side_inner_fixes(length,plate_length,plate_thickness)
{
    translate([-length/2+plate_length/2-BASE_THICKNESS/2,BASE_THICKNESS/2+plate_thickness/8,0])cube([BASE_THICKNESS*2,plate_thickness,BASE_THICKNESS],center=true);
    translate([length/2-plate_length/2+BASE_THICKNESS/2,BASE_THICKNESS/2+plate_thickness/8,0])cube([BASE_THICKNESS*2,plate_thickness,BASE_THICKNESS],center=true);
}
module beam(length,width,height,holes1,holes2)
{
    
    //if (holes2==1) beam_holes2(length=length,width=width,height=height);
    //translate ([0,0,0]) female_connector();
    //intersection(){
    //    translate ([0,0,0])     male_connector();
        union(){
            difference(){
                cube([length,width,height],center=true);
                union(){
                if (holes1==1) {
                    beam_holes1(length=length,width=width,height=height);
                }
                if (holes2==1) {
                    beam_holes2(length=length,width=width,height=height);
                }
                }
            }
        }
    //}    
}
module vertical_beam_traps(length,width,height)
{
    color([1,0,0]) rotate([0,90,0]) hex_hole_exit(h_trap=NUTHEIGHT_M3,h_hole=SCREW_SIZE1-NUTHEIGHT_M3,r_trap=SCREWSTANDARD_M3,rot=0,l_exit=20,rot_exit=-180);
    color([1,0,0]) translate([10,0,0]) rotate([0,90,0]) hex_hole_exit(h_trap=0,h_hole=SCREW_SIZE1-NUTHEIGHT_M3,r_trap=SCREWSTANDARD_M3,rot=0,l_exit=20,rot_exit=-180);
}
module vertical_beam_holes()
{
        for (i=[-floor((length-PITCH1*2)/2/PITCH1):1:floor((length-PITCH1*2)/2/PITCH1)])
        color([0,1,0]) translate([i*PITCH1,SCREW_SIZE1-BASE_THICKNESS/2,0]) rotate([-90,0,0]) hex_hole(h_trap=NUTHEIGHT_M3+0.1,h_hole=SCREW_SIZE1-NUTHEIGHT_M3,r_trap=SCREWSTANDARD_M3,rot=180);
        for (i=[-floor((length-PITCH1*2)/2/PITCH1):1:floor((length-PITCH1*2)/2/PITCH1)])
        color([0,1,0]) translate([i*PITCH1,-SCREW_SIZE1+BASE_THICKNESS/2,0]) rotate([-90,0,180]) hex_hole(h_trap=NUTHEIGHT_M3+0.1,h_hole=SCREW_SIZE1-NUTHEIGHT_M3,r_trap=SCREWSTANDARD_M3,rot=180);
        
        for (i=[-floor((length-PITCH1)/2/PITCH1):1:floor((length-PITCH1*3)/2/PITCH1)]){
        color([0,1,0]) translate([i*PITCH1+PITCH1/2,0,-SCREW_SIZE1/2-height/2]) rotate([0,180,0]) hex_hole(h_trap=NUTHEIGHT_M3+0.1,h_hole=SCREW_SIZE1-NUTHEIGHT_M3,r_trap=SCREWSTANDARD_M3,rot=180);}
        for (i=[-floor((length-PITCH1)/2/PITCH1):1:floor((length-PITCH1*3)/2/PITCH1)]){
        color([0,1,0]) translate([i*PITCH1+PITCH1/2,0,SCREW_SIZE1/2+height/2]) rotate([0,0,0]) hex_hole(h_trap=NUTHEIGHT_M3+0.1,h_hole=SCREW_SIZE1-NUTHEIGHT_M3,r_trap=SCREWSTANDARD_M3,rot=180);}
}
module vertical_beam_struts(length,width,height)
{
    
    translate([-length/2-STRUT_VERTICAL_HEIGHT/2,BASE_THICKNESS/4,0]) cube([STRUT_VERTICAL_HEIGHT,BASE_THICKNESS/2,BASE_THICKNESS],center=true);
    translate([length/2+STRUT_VERTICAL_HEIGHT/2,BASE_THICKNESS/4,0]) cube([STRUT_VERTICAL_HEIGHT,BASE_THICKNESS/2,BASE_THICKNESS],center=true);
}
module vertical_beam(length,width,height)
{
    //vertical_beam_struts(length=length,width=width,height=height);
    //vertical_beam_holes(length=length,width=width,height=height);
    
    difference()
    {
        union()
        {
            cube([length,width,height],center=true);
            vertical_beam_struts(length=length,width=width,height=height);
        }
        union(){
            translate([length/2+BASE_HEIGHT+4,0,0]) rotate([0,0,180])vertical_beam_traps(length=length,width=width,height=height);
            translate([-length/2-BASE_HEIGHT-4,0,0]) vertical_beam_traps(length=length,width=width,height=height);
    vertical_beam_holes(length=length,width=width,height=height);
        }
    }
    if (EXPLODED==1){
    translate([length/2+BASE_HEIGHT+4,0,0]) rotate([0,0,180])vertical_beam_traps(length=length,width=width,height=height);
            translate([-length/2-BASE_HEIGHT-4,0,0]) vertical_beam_traps(length=length,width=width,height=height);}
}
module horizontal_deck_grp1(tower_width)
{
    translate([length/2+BASE_HEIGHT+4,-1*tower_width/2,0]) rotate([0,0,180]) beam_side_traps(length=TOWER_LENGTH-BASE_THICKNESS,width=BASE_THICKNESS,height=BASE_THICKNESS);
    translate([-length/2-BASE_HEIGHT-4,-1*tower_width/2,0]) beam_side_traps(length=TOWER_LENGTH-BASE_THICKNESS,width=BASE_THICKNESS,height=BASE_THICKNESS);
}
module horizontal_deck_grp2(tower_width)
{
    translate([length/2+BASE_HEIGHT+4,1*tower_width/2,0]) rotate([0,0,180]) beam_side_traps(length=TOWER_LENGTH-BASE_THICKNESS,width=BASE_THICKNESS,height=BASE_THICKNESS);
    translate([-length/2-BASE_HEIGHT-4,1*tower_width/2,0]) beam_side_traps(length=TOWER_LENGTH-BASE_THICKNESS,width=BASE_THICKNESS,height=BASE_THICKNESS);
}
module support_leg1()
{
    difference(){
            union(){
                
                translate([TOWER_LENGTH/2,-10*EXPLODED-1*TOWER_WIDTH/2-BASE_THICKNESS/2-EXTRA_LEG_WIDTH/2,0]) cube([BASE_THICKNESS,EXTRA_LEG_WIDTH,BASE_HEIGHT],center=true);
                local_leg_length=PITCH1*1.5;
                translate([TOWER_LENGTH/2-local_leg_length/2,-10*EXPLODED-1*TOWER_WIDTH/2-LEG_INTERFACE_THICKNESS/2-BASE_THICKNESS/2,0]) cube([local_leg_length,LEG_INTERFACE_THICKNESS,BASE_HEIGHT],center=true);
                local_leg_height=PITCH1*2;
                translate([TOWER_LENGTH/2,-10*EXPLODED-1*TOWER_WIDTH/2-BASE_THICKNESS/2-LEG_INTERFACE_THICKNESS/2,local_leg_height/2]) cube([BASE_THICKNESS,LEG_INTERFACE_THICKNESS,local_leg_height],center=true);
            }
            union(){
                translate([TOWER_LENGTH/2-20,-10*EXPLODED-1*TOWER_WIDTH/2-BASE_THICKNESS/2-LEG_INTERFACE_THICKNESS/2-1.15,-1+BASE_HEIGHT/2-SCREWSTANDARD_M3]) color([1,0,0]) rotate([90,0,0]) hex_hole(h_trap=0,h_hole=LEG_INTERFACE_THICKNESS*10+0.1,r_trap=SCREWSTANDARD_M3,rot=180);
                translate([TOWER_LENGTH/2,-10*EXPLODED-1*TOWER_WIDTH/2-BASE_THICKNESS/2-LEG_INTERFACE_THICKNESS/2-1.15,34-1+BASE_HEIGHT/2-SCREWSTANDARD_M3]) color([1,0,0]) rotate([90,0,0]) hex_hole(h_trap=0,h_hole=LEG_INTERFACE_THICKNESS*10+0.1,r_trap=SCREWSTANDARD_M3,rot=180);
            }
        }
}
module support_leg_length()
{
    EXTRA_LEG_LENGTH=30;
    difference(){
            union(){
                
                translate([TOWER_LENGTH/2+EXTRA_LEG_LENGTH/2+BASE_THICKNESS/2-LEG_INTERFACE_THICKNESS/2,-10*EXPLODED-1*TOWER_WIDTH/2,0]) cube([EXTRA_LEG_LENGTH,BASE_THICKNESS,BASE_HEIGHT],center=true);
                local_leg_length=PITCH1*1.8;
                translate([TOWER_LENGTH/2+BASE_THICKNESS/2,-10*EXPLODED-1*TOWER_WIDTH/2+local_leg_length/2,0]) cube([LEG_INTERFACE_THICKNESS,local_leg_length,BASE_HEIGHT],center=true);
                local_leg_height=PITCH1*2.5;
                translate([TOWER_LENGTH/2+BASE_THICKNESS/2,-10*EXPLODED-1*TOWER_WIDTH/2,local_leg_height/2]) cube([LEG_INTERFACE_THICKNESS,BASE_THICKNESS,local_leg_height],center=true);
            }
            union(){                translate([TOWER_LENGTH/2+BASE_THICKNESS/2+LEG_INTERFACE_THICKNESS/2+0.05,-10*EXPLODED-1*TOWER_WIDTH/2+PITCH1+10,-1+BASE_HEIGHT/2-SCREWSTANDARD_M3]) color([1,0,0]) rotate([0,90,0]) hex_hole(h_trap=0,h_hole=LEG_INTERFACE_THICKNESS+BASE_THICKNESS+0.1,r_trap=SCREWSTANDARD_M3,rot=180);
                translate([TOWER_LENGTH/2+BASE_THICKNESS/2+LEG_INTERFACE_THICKNESS/2+0.05,-10*EXPLODED-1*TOWER_WIDTH/2,43+BASE_HEIGHT/2-SCREWSTANDARD_M3]) color([1,0,0]) rotate([0,90,0]) hex_hole(h_trap=0,h_hole=LEG_INTERFACE_THICKNESS+BASE_THICKNESS+0.1,r_trap=SCREWSTANDARD_M3,rot=180);
            }
        }
        
}
module horizontal_deck(config)
{
    
    
    if (config==CONFIG_ALL || config==CONFIG_BOTTOM_LEGS){
        translate([0,-1*TOWER_WIDTH/2,-EXPLODED*10]) {
            difference(){
            beam(TOWER_LENGTH+HOLE_PAD*2+SCREWSTANDARD_M3,BASE_THICKNESS,BASE_THICKNESS,holes1=1,holes2=1);
            union()
                {
                    beam_struts1(length=TOWER_LENGTH+HOLE_PAD*2+SCREWSTANDARD_M3,width=BASE_THICKNESS,height=BASE_THICKNESS,inside=BASE_THICKNESS);
                    beam_struts2(length=TOWER_LENGTH+HOLE_PAD*2+SCREWSTANDARD_M3,width=BASE_THICKNESS,height=BASE_THICKNESS,inside=BASE_THICKNESS);
                }
            }
            }
        translate([0,1*TOWER_WIDTH/2,-EXPLODED*10]) mirror([0,1,0]) 
            difference() {
                beam(TOWER_LENGTH+HOLE_PAD*2+SCREWSTANDARD_M3,BASE_THICKNESS,BASE_THICKNESS,holes1=1,holes2=1);
                union()
                    {
                        beam_struts1(length=TOWER_LENGTH+HOLE_PAD*2+SCREWSTANDARD_M3,width=BASE_THICKNESS,height=BASE_THICKNESS,inside=BASE_THICKNESS);
                        beam_struts2(length=TOWER_LENGTH+HOLE_PAD*2+SCREWSTANDARD_M3,width=BASE_THICKNESS,height=BASE_THICKNESS,inside=BASE_THICKNESS);
                    }
            }
        for (i=[-1,1]) translate([i*TOWER_LENGTH/2,0,0]) rotate([0,0,90]) {beam(TOWER_WIDTH-BASE_THICKNESS,BASE_THICKNESS,BASE_THICKNESS,holes1=0,holes2=1);
            difference(){
            beam_struts1(length=TOWER_WIDTH-BASE_THICKNESS,width=BASE_THICKNESS,height=BASE_THICKNESS,inside=0);
            beam_holes1(length=TOWER_WIDTH+BASE_THICKNESS,width=BASE_THICKNESS,height=BASE_THICKNESS);}
        }
    }
    if (config==CONFIG_SIDE_BEAMS_ONLY){
        length=TOWER_LENGTH-BASE_THICKNESS;
        /*
        translate([-PITCH1*2,0,0]) rotate([0,0,90]) mity_beam(length=TOWER_WIDTH-BASE_THICKNESS,x1=MITY_START1,y1=MITY_START1_Y,x2=MITY_START1+MITY_DIFF1,y2=MITY_START1_Y,x3=-MITY_START1,y3=MITY_START1_Y+MITY_DIFF2,x4=-MITY_START1-MITY_DIFF1,y4=MITY_START1_Y+MITY_DIFF2);

remainder=PITCH1*4-MITY_DIFF3;
translate([PITCH1*2,0,0]) rotate([0,0,90]) mity_beam(length=TOWER_WIDTH-BASE_THICKNESS,x1=MITY_START1,y1=MITY_START1_Y+remainder,x2=MITY_START1+MITY_DIFF1,y2=MITY_START1_Y+remainder,x3=-MITY_START1,y3=MITY_START1_Y+MITY_DIFF2+remainder,x4=-MITY_START1-MITY_DIFF1,y4=MITY_START1_Y+MITY_DIFF2+remainder);
        */
        pine64_beams_assembly();
        
        
        if (EXPLODED==1){
            horizontal_deck_grp1(length=length,tower_width=TOWER_WIDTH);
            }
        difference(){
            translate([0,-1*TOWER_WIDTH/2,0]) {
                beam(TOWER_LENGTH-BASE_THICKNESS,BASE_THICKNESS,BASE_THICKNESS,holes1=0,holes2=1);
                beam_side_inner_fixes(length=TOWER_LENGTH,plate_length=BASE_THICKNESS*2,plate_thickness=BASE_THICKNESS/3);                
            }
            horizontal_deck_grp1(length=length,tower_width=TOWER_WIDTH);
        }
        difference(){
            translate([0,1*TOWER_WIDTH/2,0]) mirror([0,1,0]) {
                beam(TOWER_LENGTH-BASE_THICKNESS,BASE_THICKNESS,BASE_THICKNESS,holes1=0,holes2=1);
                beam_side_inner_fixes(length=TOWER_LENGTH,plate_length=BASE_THICKNESS*2,plate_thickness=BASE_THICKNESS/3);
            }
            horizontal_deck_grp2(length=length,tower_width=TOWER_WIDTH);
        }
        
    }
    if (config==CONFIG_BOTTOM_LEGS){
        
        //leg1
        
        support_leg_length();
        //leg2
        translate([-TOWER_LENGTH/2,-10*EXPLODED-1*TOWER_WIDTH/2-BASE_THICKNESS/2-EXTRA_LEG_WIDTH/2,0]) cube([BASE_THICKNESS,EXTRA_LEG_WIDTH,BASE_HEIGHT],center=true);
        //leg3
        translate([TOWER_LENGTH/2,10*EXPLODED+1*TOWER_WIDTH/2+BASE_THICKNESS/2+EXTRA_LEG_WIDTH/2,0]) cube([BASE_THICKNESS,EXTRA_LEG_WIDTH,BASE_HEIGHT],center=true);
        //leg4
        translate([-TOWER_LENGTH/2,10*EXPLODED+1*TOWER_WIDTH/2+BASE_THICKNESS/2+EXTRA_LEG_WIDTH/2,0]) cube([BASE_THICKNESS,EXTRA_LEG_WIDTH,BASE_HEIGHT],center=true);
    }
}
module main_assembly(){
    translate([0,-TOWER_WIDTH/2-BASE_THICKNESS,-TOWER_HEIGHT/2-BASE_HEIGHT/2]) rotate([0,0,90])adapter1();
    translate([0,0,-1*(TOWER_HEIGHT+BASE_THICKNESS)/2-EXPLODED*10]){
        horizontal_deck(config=CONFIG_BOTTOM_LEGS);
    }
    translate([0,0,1*(TOWER_HEIGHT+BASE_THICKNESS)/2+EXPLODED*10]) rotate([0,180,0]){
        horizontal_deck(config=CONFIG_ALL);
    }
    translate([0,0,-1*PITCH1*3/2]){
        horizontal_deck(config=CONFIG_SIDE_BEAMS_ONLY);
    }
    //translate([0,0,3*PITCH1/2]){
    //    horizontal_deck(config=CONFIG_SIDE_BEAMS_ONLY);
    //}


translate([-1*TOWER_LENGTH/2,-1*TOWER_WIDTH/2,0])  mirror([1,0,0]) rotate([0,90,0]) vertical_beam(TOWER_HEIGHT,BASE_THICKNESS,BASE_THICKNESS); 
translate([-1*TOWER_LENGTH/2,1*TOWER_WIDTH/2,0]) rotate([0,90,0]) mirror([0,1,0]) mirror([0,0,1]) vertical_beam(TOWER_HEIGHT,BASE_THICKNESS,BASE_THICKNESS); 
translate([1*TOWER_LENGTH/2,-1*TOWER_WIDTH/2,0]) rotate([0,90,0]) vertical_beam(TOWER_HEIGHT,BASE_THICKNESS,BASE_THICKNESS); 
translate([1*TOWER_LENGTH/2,1*TOWER_WIDTH/2,0]) rotate([0,-90,0]) mirror([0,1,0]) mirror([0,0,1]) vertical_beam(TOWER_HEIGHT,BASE_THICKNESS,BASE_THICKNESS); 
}
module generate_vertical_beams()
{
    vertical_beam(TOWER_HEIGHT,BASE_THICKNESS,BASE_THICKNESS); 
    translate([0,BASE_THICKNESS*1.2,0]) mirror([0,1,0]) vertical_beam(TOWER_HEIGHT,BASE_THICKNESS,BASE_THICKNESS);
}
module generate_horizontal_long_beams()
{
    rotate([90,0,0]) difference(){
            beam(TOWER_LENGTH+HOLE_PAD*2+SCREWSTANDARD_M3,BASE_THICKNESS,BASE_THICKNESS,holes1=1,holes2=1);
            union()
                {
                    beam_struts1(length=TOWER_LENGTH+HOLE_PAD*2+SCREWSTANDARD_M3,width=BASE_THICKNESS,height=BASE_THICKNESS,inside=BASE_THICKNESS);
                    beam_struts2(length=TOWER_LENGTH+HOLE_PAD*2+SCREWSTANDARD_M3,width=BASE_THICKNESS,height=BASE_THICKNESS,inside=BASE_THICKNESS);
                }
            }
    
}
module generate_horizontal_short_beams()
{
    beam(TOWER_WIDTH-BASE_THICKNESS,BASE_THICKNESS,BASE_THICKNESS,holes1=0,holes2=1);
            difference(){
            beam_struts1(length=TOWER_WIDTH-BASE_THICKNESS,width=BASE_THICKNESS,height=BASE_THICKNESS,inside=0);
            beam_holes1(length=TOWER_WIDTH+BASE_THICKNESS,width=BASE_THICKNESS,height=BASE_THICKNESS);}
}
module mity_beams_assembly()
{
    
    translate([-PITCH1*2,0,0]) rotate([0,0,90]) mity_beam(length=TOWER_WIDTH-BASE_THICKNESS,x1=MITY_START1,y1=MITY_START1_Y,x2=MITY_START1+MITY_DIFF1,y2=MITY_START1_Y,x3=-MITY_START1,y3=MITY_START1_Y+MITY_DIFF2,x4=-MITY_START1-MITY_DIFF1,y4=MITY_START1_Y+MITY_DIFF2);
MITY_ASSYMETRY_Y34=-1.5;
remainder=PITCH1*4-MITY_DIFF3;
translate([PITCH1*2,0,0]) rotate([0,0,90]) mity_beam(length=TOWER_WIDTH-BASE_THICKNESS,x1=MITY_START1,y1=MITY_START1_Y+remainder,x2=MITY_START1+MITY_DIFF1,y2=MITY_START1_Y+remainder,x3=-MITY_START1,y3=MITY_START1_Y+MITY_DIFF2+remainder+MITY_ASSYMETRY_Y34,x4=-MITY_START1-MITY_DIFF1,y4=MITY_START1_Y+MITY_DIFF2+remainder+MITY_ASSYMETRY_Y34);
}
module pine64_beam(length,x1,y1)
{
    
    //Symmetric board support
    temp_extra_term=(length/2-x1-MITY_BEAM_TRAP_PART-BASE_THICKNESS/2-PINE64_BLOCK_EXTRA/2);
    pine64_beam_support(x=x1,y=y1);    
    pine64_beam_support(x=-x1,y=y1);

    echo(y1);
    if (y1>0)
    {
        translate([x1,y1/2+MITY_BEAM_THICKNESS/4-BASE_THICKNESS/4,0]) cube([MITY_BEAM_THICKNESS,y1-BASE_THICKNESS/2-MITY_BEAM_THICKNESS/2,BASE_HEIGHT],center=true);
        translate([-x1,y1/2+MITY_BEAM_THICKNESS/4-BASE_THICKNESS/4,0]) cube([MITY_BEAM_THICKNESS,y1-BASE_THICKNESS/2-MITY_BEAM_THICKNESS/2,BASE_HEIGHT],center=true);
        shift_main_beam=10;
    }
    else
    {
        translate([-x1,y1/2+MITY_BEAM_THICKNESS/4+BASE_THICKNESS/4,0]) cube([MITY_BEAM_THICKNESS,abs(y1)-BASE_THICKNESS/2+MITY_BEAM_THICKNESS/2,BASE_HEIGHT],center=true);
        translate([x1,y1/2-MITY_BEAM_THICKNESS/4+BASE_THICKNESS/4,0]) cube([MITY_BEAM_THICKNESS,abs(y1)-BASE_THICKNESS/2-MITY_BEAM_THICKNESS/2,BASE_HEIGHT],center=true);
        shift_main_beam=-10;
    }
    
    

    //Main beam
    PINE64_SHIFT_SUPPORTS=abs(y1*2)+MITY_BEAM_THICKNESS;
    /*
    //Functional strength at 45 deg
    functional_cube=20;
    
    translate([0,PINE64_SHIFT_SUPPORTS,0]){
    intersection(){
    translate([length/2-MITY_BEAM_THICKNESS-functional_cube/2,0,0]) rotate([0,0,45]) cube([length,MITY_BEAM_THICKNESS,BASE_HEIGHT],center=true);
    translate([length/2-functional_cube/2,functional_cube/2,0]) #cube([functional_cube,functional_cube,BASE_HEIGHT],center=true);}
    }
    intersection(){
    translate([length/2-MITY_BEAM_THICKNESS-functional_cube/2,0,0]) rotate([0,0,-45]) cube([length,MITY_BEAM_THICKNESS,BASE_HEIGHT],center=true);
    translate([length/2-functional_cube/2,-functional_cube/2,0]) #cube([functional_cube,functional_cube,BASE_HEIGHT],center=true);}
    intersection(){
    translate([-length/2+MITY_BEAM_THICKNESS+functional_cube/2,0,0]) rotate([0,0,-45]) cube([length,MITY_BEAM_THICKNESS,BASE_HEIGHT],center=true);
    translate([-length/2+functional_cube/2,functional_cube/2,0]) #cube([functional_cube,functional_cube,BASE_HEIGHT],center=true);}
    intersection(){
    translate([-length/2+MITY_BEAM_THICKNESS+functional_cube/2,0,0]) rotate([0,0,45]) cube([length,MITY_BEAM_THICKNESS,BASE_HEIGHT],center=true);
    translate([-length/2+functional_cube/2,-functional_cube/2,0]) #cube([functional_cube,functional_cube,BASE_HEIGHT],center=true);}
    */
    
    
    translate([0,((y1>0) ? -PINE64_SHIFT_SUPPORTS :PINE64_SHIFT_SUPPORTS),-BASE_HEIGHT/2+PINE64_BEAM_HEIGHT/2]) cube([length,MITY_BEAM_THICKNESS,PINE64_BEAM_HEIGHT],center=true);
    
    PINE_64_FIX_BLOCK=5;
    translate([-length/2+MITY_BEAM_TRAP_PART+PINE_64_FIX_BLOCK/2,((y1>0) ? -PINE64_SHIFT_SUPPORTS :PINE64_SHIFT_SUPPORTS),0]) cube([PINE_64_FIX_BLOCK,MITY_BEAM_THICKNESS,BASE_HEIGHT],center=true); 
    translate([+length/2-MITY_BEAM_TRAP_PART-PINE_64_FIX_BLOCK/2,((y1>0) ? -PINE64_SHIFT_SUPPORTS :PINE64_SHIFT_SUPPORTS),0]) cube([PINE_64_FIX_BLOCK,MITY_BEAM_THICKNESS,BASE_HEIGHT],center=true);
 
    //Fixers
    shift_amount=PITCH1/2;
    translate([length/2-MITY_BEAM_TRAP_PART/2,0,0]) pine64_beam_fixer(shift=((y1>0) ? -shift_amount :shift_amount));
    translate([-length/2+MITY_BEAM_TRAP_PART/2,0,0]) mirror([1,0,0]) pine64_beam_fixer(shift=((y1>0) ? -shift_amount :shift_amount));    
    
}
module pine64_beams_assembly()
{
    PINE64_WIDTH_PCB=79;
    PINE64_LENGTH_PCB=127;
    PINE64_WIDTH_SUB=4.25;
    PINE64_LENGTH_SUB=4.5;
    PINE64_WIDTH_DIST_HOLES=PINE64_WIDTH_PCB-2*PINE64_WIDTH_SUB;
    PINE64_LENGTH_DIST_HOLES=PINE64_LENGTH_PCB-2*PINE64_LENGTH_SUB;
    
    PINE64_Y_ETHERNET=-PINE64_LENGTH_DIST_HOLES/2;
    PINE64_Y_OTHER=PINE64_LENGTH_DIST_HOLES/2;
    
    pitch_generated_dist=PITCH1*6;
    remainder=pitch_generated_dist-PINE64_LENGTH_DIST_HOLES;
    
    
    translate([-pitch_generated_dist/2,0,0]) rotate([0,0,90]) pine64_beam(length=TOWER_WIDTH-BASE_THICKNESS,x1=PINE64_WIDTH_DIST_HOLES/2,y1=-remainder/2);
    
    translate([pitch_generated_dist/2,0,0]) rotate([0,0,90]) pine64_beam(length=TOWER_WIDTH-BASE_THICKNESS,x1=PINE64_WIDTH_DIST_HOLES/2,y1=remainder/2);
}
module generate_side_beams()
{
length=TOWER_LENGTH-BASE_THICKNESS;
difference(){
    translate([0,-1*BASE_THICKNESS,0]) {
        beam(TOWER_LENGTH-BASE_THICKNESS,BASE_THICKNESS,BASE_THICKNESS,holes1=0,holes2=1);
        beam_side_inner_fixes(length=TOWER_LENGTH,plate_length=BASE_THICKNESS*2,plate_thickness=BASE_THICKNESS/3);                
    }
    horizontal_deck_grp1(length=length,tower_width=BASE_THICKNESS*2);
}
difference(){
    translate([0,1*BASE_THICKNESS,0]) mirror([0,1,0]) {
        beam(TOWER_LENGTH-BASE_THICKNESS,BASE_THICKNESS,BASE_THICKNESS,holes1=0,holes2=1);
        beam_side_inner_fixes(length=TOWER_LENGTH,plate_length=BASE_THICKNESS*2,plate_thickness=BASE_THICKNESS/3);
    }
    horizontal_deck_grp2(length=length,tower_width=BASE_THICKNESS*2);
}
}
module adapter1()
{
    
    ADAPTER1_LENGTH=35;
    ADAPTER1_HOLES_DIST=48.5;
    ADAPTER1_CONNECT_LENGTH=ADAPTER1_HOLES_DIST*2+BASE_THICKNESS;
    ADAPTER1_CONNECT_THICKNESS=4;
    ADAPTER1_CONNECT_LENGTH2=PITCH1*7;
    ADAPTER1_BLOCK_THICKNESS=10;
    
    difference(){
    
        color([1,1,0]) cube([ADAPTER1_CONNECT_THICKNESS,ADAPTER1_CONNECT_LENGTH2,BASE_THICKNESS],center=true);
        union(){
            for(i=[-3,-2,-1,0,1,2,3]){
            color([0,1,0]) translate([ADAPTER1_CONNECT_THICKNESS/2+0.05,i*PITCH1,0]) rotate([0,90,0]) hex_hole(h_trap=NUTHEIGHT_M3,h_hole=ADAPTER1_CONNECT_THICKNESS-NUTHEIGHT_M3+0.1,r_trap=SCREWSTANDARD_M3,rot=180);
            }
        }
        }
    difference(){
        union(){
    color([1,1,0]) translate([-ADAPTER1_LENGTH/2-ADAPTER1_CONNECT_THICKNESS/2,ADAPTER1_CONNECT_LENGTH/2-BASE_THICKNESS/2,0])cube([ADAPTER1_LENGTH,BASE_THICKNESS,BASE_THICKNESS],center=true);
    color([1,1,0]) translate([-ADAPTER1_LENGTH/2-ADAPTER1_CONNECT_THICKNESS/2,-ADAPTER1_CONNECT_LENGTH/2+BASE_THICKNESS/2,0])cube([ADAPTER1_LENGTH,BASE_THICKNESS,BASE_THICKNESS],center=true);
    color([0,1,1]) translate([-ADAPTER1_LENGTH,ADAPTER1_HOLES_DIST,0]) cube([ADAPTER1_BLOCK_THICKNESS,ADAPTER1_BLOCK_THICKNESS,BASE_THICKNESS],center=true);
    color([0,1,1]) translate([-ADAPTER1_LENGTH,-ADAPTER1_HOLES_DIST,0]) cube([ADAPTER1_BLOCK_THICKNESS,ADAPTER1_BLOCK_THICKNESS,BASE_THICKNESS],center=true);
        }
        union(){
    //Flatsat board
    color([0,1,1]) translate([-ADAPTER1_LENGTH,ADAPTER1_HOLES_DIST,0.05+BASE_THICKNESS/2]) rotate([0,0,90]) hex_hole(h_trap=BASE_THICKNESS+0.1,h_hole=0,r_trap=SCREWSTANDARD_M3,rot=180);
    color([0,1,1]) translate([-ADAPTER1_LENGTH,-ADAPTER1_HOLES_DIST,0.05+BASE_THICKNESS/2]) rotate([0,0,75]) hex_hole(h_trap=BASE_THICKNESS+0.1,h_hole=0,r_trap=SCREWSTANDARD_M3,rot=180);
        }
    }
}
module singlebeamsupport(x1,y1,x2,y2,x3,y3,x4,y4)
{
    mity_beam(length=TOWER_WIDTH-BASE_THICKNESS,x1=x1,y1=y1,x2=x2,y2=y2,x3=x3,y3=y3,x4=x4,y4=y4);
}
module doublebeamsupportrectangle(length,width)
{
    double_beam(length=TOWER_WIDTH-BASE_THICKNESS,rect_length=length,rect_width=width);
}
//Assembly
//main_assembly();
//Pieces
//beam(TOWER_LENGTH+HOLE_PAD*2+SCREWSTANDARD_M3,BASE_THICKNESS,BASE_HEIGHT,holes1=0,holes2=0);
//vertical_beam(TOWER_HEIGHT,BASE_THICKNESS,BASE_THICKNESS); 
//Printing
//ARTIFACT1
//generate_vertical_beams();

//ARTIFACT2
//generate_horizontal_long_beams();
//translate([0,BASE_THICKNESS*2,0]) mirror([0,1,0]) generate_horizontal_long_beams();

//ARTIFACT3
//for (i=[-1,0]){translate([0,i*BASE_THICKNESS*2,0])generate_horizontal_short_beams();}
        
//ARTIFACT4
/*
generate_side_beams();
*/

//ARTIFACT5
/*
INTERSECT_THICKNESS=1;
intersection(){
translate([0,0,-BASE_THICKNESS/2+INTERSECT_THICKNESS/2])#cube([200,200,2],center=true);
union(){
    mity_beams_assembly();
    translate([0,TOWER_WIDTH/2-BASE_THICKNESS*2,0])cube([PITCH1*4,MITY_BEAM_THICKNESS,BASE_THICKNESS],center=true);
    translate([0,-TOWER_WIDTH/2+BASE_THICKNESS*2,0])cube([PITCH1*4,MITY_BEAM_THICKNESS,BASE_THICKNESS],center=true);
}
}
*/
//ARTIFACT5.5 - Pine64 BEAM
///*
//intersection(){
//translate([-100,0,0])#cube([200,200,200],center=true);
//pine64_beams_assembly();
//}
//*/

//ARTIFACT6
//rotate([-90,0,0]) support_leg1();
//translate([0,-20,0]) rotate([90,0,0])mirror([0,1,0]) support_leg1();


//ARTIFACT7
//rotate([0,-90,0]) support_leg_length();
//translate([0,-20,0]) rotate([0,-90,0])mirror([0,1,0]) support_leg_length();
//PLAYGROUND

//ARTIFACT8
//adapter1();
/*
INTERSECT_THICKNESS=0.5;
intersection(){
adapter1();
translate([0,0,-BASE_THICKNESS/2+INTERSECT_THICKNESS/2])#cube([200,200,2],center=true);    
}
*/
/*
difference(){
beam(TOWER_LENGTH+HOLE_PAD*2+SCREWSTANDARD_M3,BASE_THICKNESS,BASE_THICKNESS,holes1=1,holes2=1);
    union(){
            beam_struts1(length=TOWER_LENGTH+HOLE_PAD*2+SCREWSTANDARD_M3,width=BASE_THICKNESS,height=BASE_THICKNESS,inside=BASE_THICKNESS);
            beam_struts2(length=TOWER_LENGTH+HOLE_PAD*2+SCREWSTANDARD_M3,width=BASE_THICKNESS,height=BASE_THICKNESS,inside=BASE_THICKNESS);
        }}
*/        