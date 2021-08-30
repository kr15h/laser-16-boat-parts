// Name: Socket
// Description: Socket for L16 water plug at the back of the boat.
// Created: 29 Aug 2021
// Author: Krisjanis Rijnieks

use <Spiral_Extrude.scad>

$fn = 90;

socketFittingHeight = 16.5;
socketFittingOuterRadius = 11;
socketFittingInnerRadius = 9.5;

socketMountCenterRadius = 18;
socketMountSideRadius = 8;
socketMountScrewOffset = 22;
socketMountHeight = 4;
socketMountScrewRadius = 2.5;
socketMountScrewPocketDepth = 1;

socketLipHeight = .5;

socketThreadPitch = 2;
socketThreadSize = 1.5;
socketThreadZOffset =  5 + socketMountHeight - socketFittingHeight;

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
  lipHeight = socketLipHeight,
  threadPitch = socketThreadPitch,
  threadSize = socketThreadSize,
  threadZOffset = socketThreadZOffset
);

module Socket(
  fittingHeight, fittingOuterRadius, fittingInnerRadius,
  mountCenterRadius, mountSideRadius, mountScrewOffset,
  mountHeight, mountScrewRadius, mountScrewPocketDepth,
  lipHeight, threadPitch, threadSize, threadZOffset){
    
  union(){
    difference(){
      union(){
        SocketMount(
          centerRadius = mountCenterRadius,
          sideRadius = mountSideRadius,
          screwOffset = mountScrewOffset,
          height = mountHeight,
          screwRadius = mountScrewRadius,
          screwPocketDepth = mountScrewPocketDepth);
    
        union(){
          SocketFittingOuter(
            height = fittingHeight,
            outerRadius = fittingOuterRadius,
            zOffset = mountHeight);
      
          SocketLip(
            innerRadius = fittingInnerRadius,
            outerRadius = fittingOuterRadius,
            height = lipHeight, 
            zOffset = mountHeight);
        }
      } 
    
      SocketFittingInner(
        height = fittingHeight,
        innerRadius = fittingInnerRadius,
        zOffset = mountHeight);
    }
  
    SocketThread(
      pitch = threadPitch, 
      size = threadSize, 
      radius = fittingInnerRadius,
      zOffset = threadZOffset);
  }
}

module SocketFittingOuter(height, outerRadius, zOffset){
  mirror([0, 0, 1])
  translate([0, 0, -zOffset])
  cylinder(h = height, r = outerRadius, center = false);
}

module SocketFittingInner(height, innerRadius, zOffset){
  mirror([0, 0, 1])
  translate([0, 0, -zOffset - 0.5])
  cylinder(h = height + 1, r = innerRadius, center = false);
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

module SocketThread(pitch, size, radius, zOffset){
  translate([0, 0, zOffset])
  rotate([0, 0, -80])
  extrude_spiral(
    StartRadius = radius,
    ZPitch = pitch, 
    Angle = 340, 
    StepsPerRev = $fn){
    
    difference(){
      circle(r = size);
      mirror([0, 1, 0])
      translate([-size, 0, 0]) square(size = size*2);
    }
  }
}