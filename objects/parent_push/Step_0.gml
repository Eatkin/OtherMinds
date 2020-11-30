/// @description Insert description here
// You can write your code in this editor

event_inherited();

if (global.softpause)
	scr_pause_alarms();

if state!=PlayerState.beingcarried
	{
		scr_pushable_step();
	}
	
//Some stuff dealing with things that are on top of blocks
if x=xprevious and y=yprevious
	{
		exit;
	}

if ds_list_size(_list)=0
	{
		exit;
	}
	
var inst, dx, dy;
dx=x-xprevious;
dy=y-yprevious;
for (var i=0; i<ds_list_size(_list); i+=1)
	{
		inst=ds_list_find_value(_list,i);
		inst.x+=dx;
		inst.y+=dy;
	}
