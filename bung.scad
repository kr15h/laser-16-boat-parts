// Name: Plug
// Description: Plug for L16 water socket at the back of the boat.
// Created: 30 Aug 2021
// Author: Krisjanis Rijnieks

include <variables.scad>
use <Spiral_Extrude.scad>

BungBody(
  radius = bungOuterRadius,
  height = bungBodyHeight);

translate([0, 0, -bungBodyHeight])
BungThread(
  radius = bungOuterRadius,
  pitch = bungThreadPitch, 
  size = bungThreadSize);

BungCap(
  radius = bungCapRadius,
  height = bungCapHeight,
  handleHeight = bungHandleHeight,
  handleFilet = bungHandleFilet);

module BungBody(radius, height){
  mirror([0, 0, 1])
  cylinder(r = radius, h = height);
}

module BungThread(radius, pitch, size){
  translate([0, 0, size])
  extrude_spiral(
    StartRadius = radius,
    ZPitch = pitch, 
    Angle = 1060, 
    StepsPerRev = $fn){
    
    square(size = [size*2, size], center = true);
  }
}

module BungCap(radius, height, handleHeight, handleFilet){
  union(){
    cylinder(r = radius, h = height);
    intersection(){
      cylinder(r = radius, h = height + handleHeight);
      translate([-radius, 0, 0])
      rotate([90, 0, 0])
      linear_extrude(height = height, center = true){
        offset(r = handleFilet){
          offset(delta = -handleFilet){
            square(
              size = [radius*2, height + handleHeight], 
              center = false);
          }
        }
      }
    }
  }
}
