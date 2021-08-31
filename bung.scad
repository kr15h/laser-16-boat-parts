// Name: Plug
// Description: Plug for L16 water socket at the back of the boat.
// Created: 30 Aug 2021
// Author: Krisjanis Rijnieks

include <variables.scad>
use <openscad_spiral_extrude/spiral_extrude.scad>

BungBody(
  outerRadius = bungOuterRadius,
  innerRadius = bungInnerRadius,
  height = bungBodyHeight);

RetainingClip(
  height = bungBodyHeight * 3, 
  radius = bungInnerRadius);

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

module BungBody(outerRadius, innerRadius, height){
  difference(){
    mirror([0, 0, 1])
    cylinder(r = outerRadius, h = height);
    
    mirror([0, 0, 1])
    translate([0, 0, height / 3])
    cylinder(r = innerRadius, h = height / 3 * 2 + 1);
  }
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
  
      hull(){
        translate([-radius, -height/2, height/2])
        cube(size = [radius * 2, height, height]);
  
        translate([radius - handleFilet, 0, 
          height + handleHeight -handleFilet])
        rotate([90, 0, 0])
        cylinder(r = handleFilet, h = height, center = true);
  
        translate([handleFilet - radius, 0, 
          height + handleHeight - handleFilet])
        rotate([90, 0, 0])
        cylinder(r = handleFilet, h = height, center = true);
      }
    }
  }
}

module RetainingClip(height = 50, radius = 2, size = 2){
  union(){
    mirror([0, 0, 1])
    translate([radius, 0, 0])
    cylinder(h = height, d = size);
  
    translate([radius, -size / 2, -height])
    cube(size = [size * 3, size, size]);
  
    mirror([0, 0, 1])
    translate([-radius, 0, 0])
    cylinder(h = height, d = size);
  
    translate([-radius, -size / 2, -height])
    mirror([1, 0, 0])
    cube(size = [size * 3, size, size]);
  
    translate([0, 0, -height / 3 * 2])
    cube(size = [radius * 2, size, size], center = true);
  }
}
