/// @description Insert description here
// You can write your code in this editor

event_inherited();

//y=64 -> y=272
activated=0;
if scr_event_check_complete(global.edspaceevents_one,EVENTS_EDSPACE_ONE.PLATFORMLOWERED)=1
	{
		activated=2;
	}
instanceprevious=noone;
yspeed=0;
acc=1;
maxyspeed=4;
maxxspeed=3; //This is stupid but I need it for the camera
ymin=ystart;
ymax=260
playerontop=0;

//Perturbation variables
perturb=0;
perturbamount=8;
perturbationdir=1;
yunperturbed=y;