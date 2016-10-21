use <main.scad>
BUILD_VOLUME=190;
FLOOR_HEIGHT=1;
PARTS_HEIGHT=8;
//translate([0,0,-(PARTS_HEIGHT+FLOOR_HEIGHT)/2]) #cube([BUILD_VOLUME+20,BUILD_VOLUME,FLOOR_HEIGHT],center=true);
translate([0,-BUILD_VOLUME/2+4,0]) generate_vertical_beams();
translate([0,-BUILD_VOLUME/2+4+18.5,0]) generate_vertical_beams();
translate([0,-BUILD_VOLUME/2+41,0])generate_horizontal_short_beams();
translate([0,-BUILD_VOLUME/2+50,0])generate_horizontal_short_beams();
translate([0,-BUILD_VOLUME/2+59,0])generate_horizontal_long_beams();
translate([0,-BUILD_VOLUME/2+68,0])generate_horizontal_long_beams();
translate([0,-BUILD_VOLUME/2+77,0])mirror([0,1,0]) generate_horizontal_long_beams();
translate([0,-BUILD_VOLUME/2+86,0]) mirror([0,1,0])generate_horizontal_long_beams();
translate([0,-BUILD_VOLUME/2+95,0])generate_horizontal_short_beams();
translate([0,-BUILD_VOLUME/2+104,0])generate_horizontal_short_beams();

