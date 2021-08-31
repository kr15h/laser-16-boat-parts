#!/bin/bash

rm -rf images
mkdir images

openscad bung.scad --autocenter --imgsize=400,400 -o images/bung.png
openscad socket.scad --autocenter --imgsize=400,400 -o images/socket.png
openscad oring.scad --autocenter --imgsize=400,400 -o images/oring.png
openscad mold.scad --autocenter --imgsize=400,400 -o images/mold.png
