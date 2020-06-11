$fn = 100;
$key_pitch = 19.05;
$kadomaru = 1;
$switch_hole_kadomaru = 0.3;
$engrave_kadomaru = 0.5;

module kadomaru (r = 0) {
  offset (r = r) offset (r = -r) children();
}

module topplate_engrave () {
    for (x = [0, 1])
      for (y = [0, 1, 2])
        translate([(x + 1) * $key_pitch, (y + 0.5) * $key_pitch]) {
            kadomaru($engrave_kadomaru) square([4, 6], center = true);
        }
    for (x = [0, 1, 2])
      for (y = [0, 1])
        translate([(x + 0.5) * $key_pitch, (y + 1) * $key_pitch]) {
            kadomaru($engrave_kadomaru) square([6, 4], center = true);
        }
}

module topplate (engrave = false) {
  difference () {
    kadomaru(r = $kadomaru) square(3 * $key_pitch);
    for (x = [0, 1, 2])
      for (y = [0, 1, 2])
        translate([(x + 0.5) * $key_pitch, (y + 0.5) * $key_pitch]) {
            kadomaru($switch_hole_kadomaru) square(14, center = true);
        }
    if (engrave) topplate_engrave();
  }
}


// ---- preview
//color([1, 1, 1]) translate([- 44.4, 53.2, 1.6]) import("./pcb/switch42.stl");
//color([0, 0, 0, 0.2]) translate([0, 0, 1.6 + 2]) linear_extrude(3) topplate();

// ---- dxf
//topplate();
topplate_engrave();