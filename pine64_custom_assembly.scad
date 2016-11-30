use <main.scad>
BUILD_VOLUME=190;
//translate([0,0,-8/2]) #cube([BUILD_VOLUME+20,BUILD_VOLUME,1],center=true);
/*
translate([0,-BUILD_VOLUME/2+4,0]) generate_vertical_beams();
translate([0,-BUILD_VOLUME/2+4+18.5,0]) generate_vertical_beams();
translate([0,-BUILD_VOLUME/2+41,0])generate_horizontal_short_beams();
translate([0,-BUILD_VOLUME/2+50,0])generate_horizontal_short_beams();
translate([0,-BUILD_VOLUME/2+59,0])generate_horizontal_long_beams();
translate([0,-BUILD_VOLUME/2+68,0])generate_horizontal_long_beams();
translate([0,-BUILD_VOLUME/2+77,0])mirror([0,1,0]) generate_horizontal_long_beams();
translate([0,-BUILD_VOLUME/2+86,0]) mirror([0,1,0])generate_horizontal_long_beams();
*/
/*
translate([0,9,0]) generate_side_beams();
translate([0,-20+127,0]) rotate([0,0,90])
intersection(){
translate([-100,0,0])#cube([200,200,200],center=true);
pine64_beams_assembly();}
translate([20,8+127,0]) rotate([0,0,90])
intersection(){
translate([-100,0,0])#cube([200,200,200],center=true);
pine64_beams_assembly();}
*/
/*
POWER_HOLES_LENGTH=58;
POWER_HOLES_WIDTH=34.75;
singlebeamsupport(x1=-POWER_HOLES_LENGTH/2,y1=POWER_HOLES_WIDTH/2,x2=-POWER_HOLES_LENGTH/2,y2=-POWER_HOLES_WIDTH/2,x3=POWER_HOLES_LENGTH/2,y3=POWER_HOLES_WIDTH/2,x4=POWER_HOLES_LENGTH/2,y4=-POWER_HOLES_WIDTH/2);
*/
//tower_panel_fan();
/*Male side beams
LENGTH=300;
WIDTH=30;
HEIGHT=10;
intersection(){
translate([-LENGTH/2+20,0,0])#cube([LENGTH,WIDTH,HEIGHT],center=true);
generate_side_beams();
}
//*/
//Female side beams
rotate([180,0,0]){
LENGTH=250;
WIDTH=30;
HEIGHT=10;
intersection(){
translate([+LENGTH/2-20,0,0])#cube([LENGTH,WIDTH,HEIGHT],center=true);
generate_side_beams();
}
}
//*/
/*
HDD_WIDTH=84;
HDD_LENGTH=112;
doublebeamsupportrectangle(length=HDD_WIDTH,width=HDD_LENGTH);
*/
/*
PI BEAM
SHIFT_X=20;
PI_HOLES_LENGTH=58;
PI_HOLES_WIDTH=49;
singlebeamsupport(x1=-PI_HOLES_LENGTH/2-SHIFT_X,y1=PI_HOLES_WIDTH/2,x2=-PI_HOLES_LENGTH/2-SHIFT_X,y2=-PI_HOLES_WIDTH/2,x3=PI_HOLES_LENGTH/2-SHIFT_X,y3=PI_HOLES_WIDTH/2,x4=PI_HOLES_LENGTH/2-SHIFT_X,y4=-PI_HOLES_WIDTH/2,standard=2);
*/
/*
SWITCH_WIDTH=78;
SWITCH_LENGTH=112;
doublebeamsupportrectangle(length=SWITCH_WIDTH,width=SWITCH_LENGTH);
*/