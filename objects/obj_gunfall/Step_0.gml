/// @description

x+=xspeed;
y+=yspeed;
xspeed-=deceleration;
if (abs(xspeed)<=2*deceleration)
	{
		xspeed=0;
	}
yspeed+=global.gravstrength;

if (bbox_top>room_height)
	{
		instance_destroy();
	}