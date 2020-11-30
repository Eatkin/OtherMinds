/// @description Insert description here
// You can write your code in this editor
event_inherited();

activated=0;
//This sets activation and x position as appropriate if event has been completed
if scr_event_check_complete(global.edspaceevents_one,EVENTS_EDSPACE_ONE.EDSPACEFOUR_PLATFORMONE)=1
	{
		x=0-sprite_width;
		activated=2;
	}
instanceprevious=noone;
xspeed=0;
yspeed=0;
maxyspeed=3;
maxxspeed=3; //This is stupid but I need it for the camera
xdirection=-1;