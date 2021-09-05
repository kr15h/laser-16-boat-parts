// Name: Oring
// Description: 
// Oring for the bung/socket interface.
// Created: 30 Aug 2021
// Author: Krisjanis Rijnieks

include <variables.scad>

Oring();

module Oring(){
  difference(){
    cylinder(
      d = threadDiameter + oringThickness * 2 + oringTolerance,
      h = oringHeight,
      center = true);
    cylinder(
      d = threadDiameter + oringTolerance,
      h = oringHeight + 1,
      center = true);
  }
}
