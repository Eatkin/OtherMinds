//Created 17/08.19
//Last updated 09/11/19

//Trying to genrealise jumping into a script

//Let's first check the air mask can fit and it not exit
if (airmaskenabled==true)
	{
		mask_index=maskair;
		if (place_meeting(x,y,obj_solid))
			{
				mask_index=masknormal;
				exit;
			}
	}

//Obseleted (because it doesn't work and its bad)
//var dy=yprevious-y;
//dy=clamp(dy,0,-jumpheight);
if (place_meeting(x,y-dsin(global.gravdirection),obj_solid))
	exit;
yspeed=jumpheight*dsin(global.gravdirection);

scr_play_sound(sound_jump,0,0);
state=PlayerState.air;

jumpbuffertime=0;