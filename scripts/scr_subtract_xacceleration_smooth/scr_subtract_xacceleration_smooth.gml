//Created 16/07/19
//Last updated 16/07/19

//Smooth acceleration
//Pass hinput to move with player input
//Otherwise just pass whatever condition (usually directionfacing)
//This moves to idle if xspeed=0
//xspeed-=1.5*sign(xspeed)*max(acceleration,(1/accelerationreductionfactor)*sin(abs(xspeed)*(maxxspeed+1)/(5*pi)));
xspeed-=1.5*sign(xspeed)*max(acceleration,(1/accelerationreductionfactor)*sin(pi*0.5*abs(xspeed)/maxxspeed));
if abs(xspeed)<1
	{
		xspeed=0;
		exit;
	}