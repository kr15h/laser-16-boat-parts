// Name: Oring
// Description: Oring for the bung/socket interface.
// Created: 30 Aug 2021
// Author: Krisjanis Rijnieks

include <variables.scad>

Oring(
  innerRadius = oringInnerRadius,
  outerRadius = oringOuterRadius,
  height = oringHeight
);

module Oring(innerRadius, outerRadius, height){
  difference(){
    cylinder(r = oringOuterRadius, h = oringHeight, center = true);
    cylinder(r = oringInnerRadius, h = oringHeight + 1, center = true);
  }
}