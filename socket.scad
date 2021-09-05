// Name: Socket
// Description: 
// Socket for L16 water plug at the back of the boat.
// Created: 29 Aug 2021
// Author: Krisjanis Rijnieks

include <variables.scad>
use <threads-scad/threads.scad>

Socket();

module Socket(){
  union(){
    SocketMount();
    SocketFitting();
    SocketLip();
  }
}

module SocketFitting(){
  
  // Draw the top part of the socket so that 
  // it partly melts into the mount part
  
  mirror([0, 0, 1])
  difference(){  
    translate([0, 0, socketMountHeight / 2])
    cylinder(
      d = socketOuterDiameter,
      h = threadHeight / 2 - socketMountHeight / 2);    
    translate([0, 0, -0.5])
    cylinder(
      d = threadDiameter,
      h = threadHeight / 2 + 1);
  }
  
  // Draw the thread part of the socket

  rotate([180, 0, 0])
  translate([0, 0, threadHeight / 2])
  ScrewHole(
    outer_diam = threadDiameter,
    height = threadHeight / 2,
    pitch = threadPitch,
    position=[0,0,0], rotation=[0,0,0],
    tooth_angle = threadToothAngle,
    tolerance = 0){
      cylinder(
        d = socketOuterDiameter,
        h = threadHeight / 2);
    }
}

module SocketMount(){
  translate([0, 0, -socketMountHeight])
  difference(){
    SocketMountFace();
    SocketMountHoles();
    SocketMountPockets();
  }
}

module SocketMountFace(){
  linear_extrude(
    height = socketMountHeight,
    center = false,
    scale = 0.95){

    hull(){
      circle(d = socketMountDiameterA);
      translate([socketMountScrewOffset, 0, 0])
      circle(d = socketMountDiameterB);
      translate([-socketMountScrewOffset, 0, 0])
      circle(d = socketMountDiameterB);
    }
  }
}

module SocketMountHoles(){
  
  // Right hole to cut
  
  translate([socketMountScrewOffset, 0, -0.5])
  cylinder(
    d = socketMountScrewDiameter,
    h = socketMountHeight + 1,
    center = false);
  
  // Left hole to cut
  
  translate([-socketMountScrewOffset, 0, -0.5])
  cylinder(
    d = socketMountScrewDiameter,
    h = socketMountHeight + 1,
    center = false);
  
  // Center hole to cut
  
  translate([0, 0, -0.5])
  cylinder(
    d = threadDiameter,
    h = socketMountHeight + 1,
    center = false);
}

module SocketMountPockets(){
  
  // Right pocket to cut
  
  translate([
    socketMountScrewOffset, 0,
    socketMountHeight - socketMountScrewPocketDepth])
  cylinder(
    d = socketMountScrewDiameter * 2,
    h = socketMountScrewPocketDepth * 2,
    center = false);
  
  // Left pocket to cut
  
  translate([
    -socketMountScrewOffset, 0,
    socketMountHeight - socketMountScrewPocketDepth])
  cylinder(
    d = socketMountScrewDiameter * 2,
    h = socketMountScrewPocketDepth * 2,
    center = false);
}

module SocketLip(){
  thickness = (socketOuterDiameter - threadDiameter) / 2;
  translate([0, 0, -0.1])
  rotate_extrude(angle = 360, convexity = 2){
    translate([threadDiameter / 2, 0, 0])
    polygon(points = [
      [0, -0.1], [0, 0],
      [thickness / 2, socketLipHeight], [thickness, -0],
      [thickness, -0.1]]);
  }
}
