// Name: Bung
// Description: 
// Bung for L16 water socket at the back of the boat.
// Created: 30 Aug 2021
// Author: Krisjanis Rijnieks

include <variables.scad>
use <threads-scad/threads.scad>

Bung();

module Bung(){
  union(){
    BungBody(
      outerRadius = bungOuterRadius,
      innerRadius = bungInnerRadius,
      height = bungBodyHeight);

    RetainingClip(
      height = bungBodyHeight * 3, 
      radius = bungInnerRadius);

    BungCap(
      radius = bungCapRadius,
      height = bungCapHeight,
      handleHeight = bungHandleHeight,
      handleFilet = bungHandleFilet);
  }
}

module BungBody(outerRadius, innerRadius, height){
  union(){
    mirror([0, 0, 1])
    cylinder(r = bungOuterRadius, h = bungBodyHeight / 2);
    
    difference(){
      rotate([180, 0, 0])
      translate([0, 0, bungBodyHeight / 2])
      AugerThread(
        outer_diam = bungOuterRadius * 2 + bungThreadSize, 
        inner_diam = bungOuterRadius * 2, 
        height = bungBodyHeight / 2, 
        pitch = bungThreadPitch, 
        tooth_angle=45, tolerance=0, 
        tip_height=bungThreadPitch, tip_min_fract=0.75);
      
      mirror([0, 0, 1])
      translate([0, 0, bungBodyHeight / 2])
      cylinder(r = bungInnerRadius, h = bungBodyHeight  / 2 + 1);
    }
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
