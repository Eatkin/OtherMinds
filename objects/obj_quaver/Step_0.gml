/// @description

if (global.hardpause)
	exit;
	
x+=xspeed;
y+=yspeed;

image_alpha-=0.02;

if (image_alpha<=0)
	instance_destroy();