// Name: Mold
// Description: Oring mold for the bung/socket interface.
// Created: 30 Aug 2021
// Author: Krisjanis Rijnieks

include <variables.scad>
use <oring.scad>

difference(){
  MoldBase(
    height = oringHeight,
    size = oringOuterRadius * 2,
    marginXY = moldMarginXY,
    marginZ = moldMarginZ);
  
  Oring(
    innerRadius = oringInnerRadius,
    outerRadius = oringOuterRadius,
    height = oringHeight
  );
}

module MoldBase(height, size, marginXY, marginZ){
  translate([0, 0, height/2 - 0.01])
  mirror([0, 0, 1])
  linear_extrude(height = height + marginZ){
    square(
      size = size + moldMarginXY*2, 
      center = true);
  }
}