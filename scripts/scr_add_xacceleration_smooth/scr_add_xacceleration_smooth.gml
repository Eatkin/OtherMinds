//Created 16/07/19
//Last updated 31/07/19

//Smooth acceleration
//Pass hinput to move with player input
//Otherwise just pass whatever condition (usually directionfacing)

var multiplyer=argument0;
	
//This is a TON more responsive than the commented out version
//Okay turns out this version of the code was bugged and the sin evaluated turned negative for high enough speeds
//xspeed+=0.5*multiplyer*(1/accelerationreductionfactor)*sin(abs(xspeed)*(maxxspeed+1)/(5*pi))+multiplyer*acceleration;
if (xspeed==clamp(xspeed,-maxxspeed,maxxspeed))
	xspeed+=0.5*multiplyer*((1/accelerationreductionfactor)*sin(pi*0.5*(abs(xspeed)/maxxspeed))+acceleration);
else
	scr_subtract_xacceleration_smooth();
	
//Literally don't even know what this is:
//xspeed+=0.5*multiplyer*max(acceleration,(1/accelerationreductionfactor)*sin(abs(xspeed)*(maxxspeed+1)/(5*pi)));
//xspeed=clamp(xspeed,-maxxspeed, maxxspeed);