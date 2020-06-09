/*
//                  N E S P R E S S O
//                  C U P H O L D E R
//
//  - joints are 'odd' floating points to make good fits
//  - set $bridge to false to elimnate bridge joints + parts
//
// @author : liquidrinu
*/

cube([0,0,0]); // dummyload

//////////////
// [constants]

$beam_length = 40;
$beam_width = 12;
$beam_depth = 8;

$slider_hole_width = 4;
$slider_hole_height = 8;

$bridge = true;
$bridge_joint_length = 6;

//////////////
// [render]

module render () {

  // * comment out single lines if u want single piece extractions

  // left beams - order: [top,middle,dispenser]
  mirror([0,10,0]) translate([0,5,0]) beam(4,true,true);
  mirror([0,20,0]) translate([0,25,0]) beam(3,true,false);
  mirror([0,10,0]) translate([0,45,0]) dispenser();

  // right beams - order: [top,middle,dispenser]
  translate([0,25,0]) beam(3,true,false);
  translate([0,5,0]) beam(4,true,true);
  translate([0,45,0]) dispenser();

  // bridge pieces
  if($bridge) {
    translate([50,45,0]) bridge();
    translate([70,45,0]) bridge();
    translate([90,45,0]) bridge();
  }
} render();


//////////////
// [modules]
module beam ($units, $joints_m, $joints_f) {

  // beam full
  difference(){

    // body
    cube([
      $beam_length * $units,
      $beam_width,
      $beam_depth
    ]);

    // slider hole
    translate([0,7,4]){

      cube([
        $beam_length * $units,
        $slider_hole_width,
        $slider_hole_height
      ]);

      // cutout side
      translate([8,-8,-4]){
        color("blue")
        cube([
          $beam_length * $units -16,
          $beam_width -6,
          $beam_depth
        ]);
      }
    }

  //joints female
    if($joints_f){
      translate([0,1,0]){
        color("red") cube([4.1,2.1,10]);
        translate([1.9,2,0]){
          color("red") cube([2.2,2,10]);
        }
      }
    }
  }

  // sliderhole inner ridge
  translate([0, 10,0]){
    cube([
      $beam_length * $units,
      1,
      6
    ]);
  }

  // joints male
  if($joints_m){
    translate([
      $beam_length * $units,
      1.1,
      0
    ]){
      color("red") cube([3.9,1.8,8]);
      translate([2.1,1.8,0]){
        color("green") cube([1.8,1.8,8]);
      }
    }
  }

  // bridge joints
  if($bridge == true) {
    rotate([0,0,180]){
      translate([-16,-5,$beam_depth / 2 -2 ]){
        color("purple")
        cube([
          3.8,
          $bridge_joint_length / 2,
          3.8
        ]);
      }
    }
  }
}

module dispenser () {

  $beam_length = 30;

  // sliderhole add-on
  difference(){
    translate([0,14,0]){
      rotate([0,0,-6]) {
        cube([$beam_length -4,2,6]);
      }
    }
  }

  // beam full
  difference(){

  // body
  cube([
    $beam_length,
    16,
    $beam_depth
  ]);

  // slider hole
  translate([-2,5,0]){
    rotate([0,0,-6]) {
      translate([0,7,4]){
        cube([$beam_length ,3,6]);
      }
    }
  }

  translate([0,7,4]){

    cube([
      $beam_length + 8,
      5,
      6
    ]);

    // ugly fill hole
    translate([-30,0,0]){
      cube([$beam_length + 6,5,6]);
    }

    // cutout side
    translate([8,-8,-4]){
      color("blue")
      cube([
        $beam_length - 8,
        6,
        $beam_depth
      ]);
    }
  }

  //joints female
  translate([0,1,0]){
    color("red") cube([4.1,2.1,10]);
      translate([1.9,2,0]){
        color("red") cube([2.2,2,10]);
      }
  }

  // ugly fill hole
  rotate([0,0,-6]) {
    translate([-8,10,4]){
      cube([120,4,8]);
    }
  }

  //  angled outline beam
  rotate([0,0,-6]) {
    translate([0,16.5,0]){
      cube([$beam_length ,20,12]);
    }
  }

  // bottom body chop chop
    translate([28,-10,0]){
      cube([10,26,$beam_depth]);
    }
  }

  // ugly fill bottom beam
  translate([24,0,0]){
    cube([4.4,13.8,$beam_depth]);
  }

  // bridge joints
  if($bridge == true) {
    rotate([0,0,180]){
      translate([-16,-5,$beam_depth / 2 -2 ]){
        color("purple")
        cube([
          3.8,
          $bridge_joint_length / 2,
          3.8
        ]);
      }
    }
  }
}

module bridge () {

  difference() {
    cube([8,45,$bridge_joint_length]);

    // joints (cutout)
    translate([2,2,$bridge_joint_length / 2]){
      cube([4,4, $bridge_joint_length / 2]);
    }
    translate([2,39,$bridge_joint_length / 2]){
      cube([4,4, $bridge_joint_length / 2]);
    }
  }
}
