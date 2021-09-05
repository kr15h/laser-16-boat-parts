// Name: Socket
// Description: Socket for L16 water plug at the back of the boat.
// Created: 29 Aug 2021
// Author: Krisjanis Rijnieks

include <variables.scad>
use <threads-scad/threads.scad>

Socket(
  fittingHeight = socketFittingHeight, 
  fittingOuterRadius = socketFittingOuterRadius, 
  fittingInnerRadius = socketFittingInnerRadius,
  mountCenterRadius = socketMountCenterRadius,
  mountSideRadius = socketMountSideRadius,
  mountScrewOffset = socketMountScrewOffset,
  mountHeight = socketMountHeight,
  mountScrewRadius = socketMountScrewRadius,
  mountScrewPocketDepth = socketMountScrewPocketDepth,
  lipHeight = socketLipHeight
);

module Socket(
  fittingHeight, fittingOuterRadius, fittingInnerRadius,
  mountCenterRadius, mountSideRadius, mountScrewOffset,
  mountHeight, mountScrewRadius, mountScrewPocketDepth,
  lipHeight){
    
  union(){
    translate([0, 0, -socketMountHeight])
    SocketMount(
      centerRadius = mountCenterRadius,
      sideRadius = mountSideRadius,
      screwOffset = mountScrewOffset,
      height = mountHeight,
      screwRadius = mountScrewRadius,
      screwPocketDepth = mountScrewPocketDepth);
    
    translate([0, 0, -socketMountHeight / 2])
    SocketFitting();

    translate([0, 0, -socketMountHeight])
    SocketLip(
      innerRadius = fittingInnerRadius,
      outerRadius = fittingOuterRadius,
      height = lipHeight, 
      zOffset = mountHeight);   
  } 
}

module SocketFitting(){
  mirror([0, 0, 1])
  difference(){
    cylinder(
      r = socketFittingOuterRadius, 
      h = socketFittingHeight / 2);    
    translate([0, 0, -0.5])
    cylinder(
      r = socketFittingInnerRadius, 
      h = socketFittingHeight / 2 + 1);
  }
  
  rotate([180, 0, 0])
  translate([0, 0, socketFittingHeight / 2])
  ScrewHole(
    outer_diam = socketFittingInnerRadius * 2, 
    height = socketFittingHeight / 2, 
    pitch = threadPitch, 
    position=[0,0,0], rotation=[0,0,0], 
    tooth_angle = threadToothAngle, 
    tolerance = 0){
      cylinder(
        r = socketFittingOuterRadius, 
        h = socketFittingHeight / 2);
    }
}

module SocketMount(
  centerRadius, sideRadius, screwOffset, height, 
  screwRadius, screwPocketDepth){
  
  difference(){
    difference(){
      SocketMountFace(
        centerRadius = centerRadius,
        sideRadius = sideRadius,
        screwOffset = screwOffset,
        height = height);

      SocketMountHoles(
        screwOffset = screwOffset, 
        screwRadius = screwRadius, 
        height = height);
      
      cylinder(
        r = socketFittingInnerRadius, 
        h = height * 3, center = true);
    }
  
    SocketMountPockets(
      screwOffset = screwOffset, 
      screwRadius = screwRadius, 
      height = height, 
      depth = screwPocketDepth);
  }
}

module SocketMountFace(centerRadius, sideRadius, screwOffset, height){
  linear_extrude(height = height, center = false, scale = 0.95){
    hull(){
      circle(r = centerRadius);
      translate([screwOffset, 0, 0]) 
      circle(r = sideRadius);
      translate([-screwOffset, 0, 0]) 
      circle(r = sideRadius);
    }
  }
}

module SocketMountHoles(screwOffset, screwRadius, height){
  translate([screwOffset, 0, -0.5])
  cylinder(r = screwRadius, h = height + 1, center = false);
  translate([-screwOffset, 0, -0.5])
  cylinder(r = screwRadius, h = height + 1, center = false);
}

module SocketMountPockets(screwOffset, screwRadius, height, depth){
  translate([screwOffset, 0, height - depth])
  cylinder(r = screwRadius * 2, h = depth * 2, center = false);
  translate([-screwOffset, 0, height - depth])
  cylinder(r = screwRadius * 2, h = depth * 2, center = false);
}

module SocketLip(innerRadius, outerRadius, height, zOffset){
  thickness = outerRadius - innerRadius;
  translate([0, 0, zOffset])
  rotate_extrude(angle = 360, convexity = 2){
    translate([innerRadius, 0, 0])
    polygon(points = [
      [0, -0.1], [0, 0], 
      [thickness/2, height], [thickness, -0], 
      [thickness, -0.1]]);
  }
}