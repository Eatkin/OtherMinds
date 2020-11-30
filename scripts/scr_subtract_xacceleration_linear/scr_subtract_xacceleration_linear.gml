//Created 16/07/19
//Last updated 16/07/19

//Smooth acceleration
//Pass hinput to move with player input
//Otherwise just pass whatever condition (usually directionfacing)

xspeed-=sign(xspeed)*acceleration;
//xspeed=clamp(xspeed,-maxxspeed, maxxspeed);
if abs(xspeed)<=acceleration
	{
		xspeed=0;
	}