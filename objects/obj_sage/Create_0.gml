/// @description Create script
// You can write your code in this editor

event_inherited();

scr_set_vibration(1,1,10);

//Sage is an idiot and can't stop getting stuck in walls
while position_meeting(bbox_right,y,obj_solid)
	{
		x-=1;
	}
while position_meeting(bbox_left,y,obj_solid)
	{
		x+=1;
	}
while position_meeting(x,bbox_bottom,obj_solid)
	{
		y-=1;
	}
while position_meeting(x,bbox_top,obj_solid)
	{
		y+=1;
	}
			
scr_Sage_create_new();