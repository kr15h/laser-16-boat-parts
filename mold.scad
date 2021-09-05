// Name: Mold
// Description: 
// Oring mold for the bung/socket interface.
// Created: 30 Aug 2021
// Author: Krisjanis Rijnieks

include <variables.scad>
use <oring.scad>

difference(){
  MoldBase();
  union(){
    Oring();
    translate([0, 0, -oringHeight / 2]) Oring();
  }
}

module MoldBase(){
  mirror([0, 0, 1])
  linear_extrude(height = oringHeight + moldMarginZ){
    square(
      size = threadDiameter + oringThickness * 2 + oringTolerance + moldMarginXY * 2,
      center = true);
  }
}
