/// @description Insert description here
// You can write your code in this editor

//Find the coordinate we're supposed to be at
var _menux;
with (obj_main_menu)
	{
		_menux=max(0,(menutab-1))*480;
	}
	
//Queue a coordinate for Sage
var tail=ds_queue_tail(coordinatequeue);
var queuecoord=lerp(tail,x-dir*sagedist,0.1);
ds_queue_enqueue(coordinatequeue,queuecoord);

sagex=ds_queue_dequeue(coordinatequeue);

offsetcounter+=2;
sageyoffset=2*dsin(offsetcounter);
sagesubimg+=1/6;
sagesubimg=sagesubimg%9;

//Find the nearest point
//If we're within the bounds of the menu we'll slow down
// (Also slow down earlier for the additional options because there's a cliff there)
if x=clamp(x,_menux+32,_menux+448) or (x>(MAINTAB.ADDOPTIONS-1)*480 and _menux=(MAINTAB.ADDOPTIONS-1)*480)
	{
		if xspeed!=0
			{
				scr_subtract_xacceleration_smooth();
			}
	}
else
	{
		dir=sign(_menux-x);
		if x<_menux
			{
				xtarget=_menux+96;
			}
		else
			{
				xtarget=_menux+384;
			}
		scr_add_xacceleration_smooth(dir);
	}
	
x+=xspeed;
	
//Sprites
if abs(xspeed)>0
	{
		sprite_index=spr_Ed_run;
		image_speed=min(abs(xspeed)/maxxspeed,1);
	}
else
	{
		sprite_index=spr_Ed_idle;
		image_speed=1;
	}

if xspeed!=0
	{
		image_xscale=sign(xspeed);
	}