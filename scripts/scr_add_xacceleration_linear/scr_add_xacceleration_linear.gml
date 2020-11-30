//Created 16/07/19
//Last updated 16/07/19

//Smooth acceleration
//Pass hinput to move with player input
//Otherwise just pass whatever condition (usually directionfacing)

var multiplyer=argument0;
	
if (xspeed==clamp(xspeed,-maxxspeed,maxxspeed))
	xspeed+=multiplyer*acceleration;
else
	scr_subtract_xacceleration_linear();
//xspeed=clamp(xspeed,-maxxspeed, maxxspeed);