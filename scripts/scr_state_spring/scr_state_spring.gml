//Created 06/10/19
//Last updated 06/10/19

var gravMultiplier=dsin(global.gravdirection);

if (sprite_index!=sprite_spring)
	{
		sprite_index=sprite_spring;
		image_index=0;
	}
//Just waits until animation end then propells player into the air
if image_index>image_number-0.5
	{
		xspeed=0;
		yspeed=jumpheight*1.5*gravMultiplier;
		state=PlayerState.air;
		if (global.currentinstance==id)
			scr_set_vibration(1,1,10);
	}