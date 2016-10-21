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
translate([0,9,0]) generate_side_beams();
translate([0,-20+127,0]) rotate([0,0,90])
intersection(){
translate([-100,0,0])#cube([200,200,200],center=true);
pine64_beams_assembly();}
translate([20,8+127,0]) rotate([0,0,90])
intersection(){
translate([-100,0,0])#cube([200,200,200],center=true);
pine64_beams_assembly();}