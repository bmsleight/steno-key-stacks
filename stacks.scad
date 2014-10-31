// To make stack for keys on QWERTY/QWERZY keyboards, turning it in to a steno machine.
//More information at http://openstenoproject.org/ 

//The MIT License (MIT)
// Copyright (c) 2014 Brendan M. Sleight

// Write.scad - Attribution-ShareAlike (CC BY-SA)
//
// Share — copy and redistribute the material in any medium or format
// Adapt — remix, transform, and build upon the material
// for any purpose, even commercially
//
//  Routines for writing text in OpenSCAD.
//  Using a mirror of Write.scad from http://www.thingiverse.com/thing:16193
// Licence: CC-BY-SA by HarlanDMii
//
include <write/Write.scad>;



// Uncomment which every group you need

// Whole set, without letter engraving
stacks(letters, engrave=0);

// Whole set, with letters engraved on surface.
// Note isf using letters, falls under CC BY-SA
//stacks(letters, engrave=1);

//This just gives you two example letters, not the whole set.
//stacks(letters_short);



// Standard write.scad font
font = "write/Letters.dxf";



key_size_x = 14;
key_size_y = 18;
key_size_z_upper = 1.6;
key_size_x_lower = 10;
key_size_y_lower = 10;
key_size_z_lower = 3.4;


letters_short = [ 
  ["S", 1, 0], 
  ["T", 1, 0], 
];

//concat in my version
letters = [ 
  ["S", 1, 0], 
  ["T", 1, 0], 
  ["P", 1, 0],
  ["H", 1, 0],

  ["S", 3, 1],
  ["K", 3, 1],
  ["W", 3, 1],
  ["R", 3, 1],

  ["*", 0, 0],
  ["F", 1, 0],
  ["P", 1, 0],
  ["L", 1, 0],
  ["T", 1, 0],
  ["D", 0, 0],

  ["*", 0, 1], 
  ["R", 3, 1],
  ["B", 3, 1],
  ["G", 3, 1],
  ["S", 3, 1],
  ["Z", 0, 1],

  ["A", 4, 1],
  ["O", 2, 1],
  ["E", 4, 1],
  ["U", 2, 1],

];

// Loop to print all the letters in a 8x rows
module stacks(letters=[], engrave=0)
{
  
    for ( i = [0 : len(letters)-1] )
    {
      translate([((i%8)*(key_size_z_lower+key_size_z_upper+2)) , 
                 round( (i/8)-0.4995 ) * (key_size_y + 2.8), 
                 0]) 
        front_face(letters[i][0], letters[i][1], letters[i][2], engrave=engrave);
    }
 
}

// Make the made key stack
module front_face(symbol="K", position=0, shape=-1, engrave=0)
{
  rotate([0,90,0])
  {
    difference()
    {
      base_panel(shape);
      finger_rest(position);
      if(engrave == 0)
      {
      }
      if(engrave == 1)
      {
        translate([0,0,key_size_z_upper-0.2]) write(symbol,h=10,t=key_size_z_upper, font=font, center=true, bold=1);
      }
    }
    translate([0,0,-(key_size_z_upper+key_size_z_lower/2)/2]) key_mount();
  }
}

// Carve-out the finger rest in any of four positions.
module finger_rest(position=0)
{
  if(position == 0) 
  {

  }
  if(position == 1) 
  {
    translate([0,-key_size_y/2,key_size_x/2]) finger_rest_hole(0);
  }
  if(position == 2) 
  {
    translate([-key_size_x/2,0,key_size_x/2]) finger_rest_hole(1);
  }
  if(position == 3) 
  {
    translate([0,key_size_y/2,key_size_x/2]) finger_rest_hole(0);
  }
  if(position == 4) 
  {
    translate([key_size_x/2,0,key_size_x/2]) finger_rest_hole(1);
  }

}

module finger_rest_hole(strech=0)
{
  if(strech == 0)
  {
     scale([1.75,1.25,1.]) sphere(r=key_size_x/2);
  }
  if(strech == 1)
  {
     scale([1.25,1.75,1]) sphere(r=key_size_x/2);
  }
}

// The basic shaep will be a rectanle or a rounded rectangle
module base_panel(shape=-1)
{
  if(shape == 0)
  {
      translate([0,key_size_y/4,0]) cube([key_size_x, key_size_y/2, key_size_z_upper], center=true);
      translate([0,-key_size_y/4,0]) cube([key_size_x, key_size_y/2, key_size_z_upper], center=true);
  }
  else
  {
    hull()
    {
      translate([0,shape*key_size_y/4,0]) cube([key_size_x, key_size_y/2, key_size_z_upper], center=true);
      translate([0,shape*-key_size_y/8,0]) cylinder(h=key_size_z_upper, r=key_size_x/2, center=true);
  //  #  translate([0,-shape*key_size_y/4,0]) cube([key_size_x, key_size_y/2, key_size_z_upper], center=true);
    }
  }
}

//Connecs to the keyboard, lifts away to ensure no other key are pressed down
module key_mount()
{
  cylinder(r1=key_size_x_lower/4, r2=key_size_x_lower/1.5, h=key_size_z_lower
, center=true);
}

// No longer used.
module round_top()
{
  difference()
  {
    cube([key_size_x_lower, key_size_x_lower, key_size_x_lower], center=true);
    translate([0,0,key_size_x_lower]) sphere(r=key_size_x_lower);
  }
}
