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
    BungBody();
    RetainingClip();
    BungCap();
  }
}

module BungBody(){
  translate([0, 0, 0.1])
  rotate([180, 0, 0])
  ScrewThread(
    outer_diam = threadDiameter,
    height = threadHeight + 0.1,
    pitch = threadPitch,
    tooth_angle = threadToothAngle,
    tolerance = -threadTolerance,
    tip_height = threadPitch,
    tip_min_fract = 0.75);
}

module BungCap(){
  union(){
    
    // Draw base of the cap
    
    cylinder(
      d = bungCapDiameter, 
      h = bungCapHeight);

    // Use a cylinder to cut overlapping corners

    intersection(){
      cylinder(
        d = bungCapDiameter, 
        h = bungCapHeight + bungHandleHeight);

      hull(){
        
        // Draw base of the cap
        
        translate([
          -bungCapDiameter / 2, 
          -bungCapHeight / 2, 
          bungCapHeight / 2])
        
        cube(size = [
          bungCapDiameter, 
          bungCapHeight, 
          bungCapHeight]);

        // Draw top right filet

        translate([
          bungCapDiameter / 2 - bungHandleFilet, 0, 
          bungCapHeight + bungHandleHeight - bungHandleFilet])
        
        rotate([90, 0, 0])
        cylinder(
          r = bungHandleFilet, 
          h = bungCapHeight, 
          center = true);

        // Draw top left filet

        translate([
          bungHandleFilet - bungCapDiameter / 2, 0,
          bungCapHeight + bungHandleHeight - bungHandleFilet])
        
        rotate([90, 0, 0])
        cylinder(
          r = bungHandleFilet, 
          h = bungCapHeight, 
          center = true);
      }
    }
  }
}

module RetainingClip(){
  union(){
    
    // Draw right leg
    
    mirror([0, 0, 1])
    translate([threadDiameter / 4, 0, 0])
    cylinder(
      h = threadHeight * 3, 
      d = bungRetainerDiameter);

    translate([
      threadDiameter / 4, 
      -bungRetainerDiameter / 2, 
      -threadHeight * 3])
    cube(size = [
      bungRetainerDiameter * 3, 
      bungRetainerDiameter, 
      bungRetainerDiameter]);
    
    // Draw left leg
    
    mirror([0, 0, 1])
    translate([-threadDiameter / 4, 0, 0])
    cylinder(
      h = threadHeight * 3, 
      d = bungRetainerDiameter);

    translate([
      -threadDiameter / 4, 
      -bungRetainerDiameter / 2, 
      -threadHeight * 3])
    mirror([1, 0, 0])
    cube(size = [
      bungRetainerDiameter * 3, 
      bungRetainerDiameter, 
      bungRetainerDiameter]);
      
    // Draw bridge
      
    translate([0, 0, -threadHeight * 2])
    cube(size = [
      threadDiameter / 2,
      bungRetainerDiameter,
      bungRetainerDiameter],
      center = true);
  }
}
