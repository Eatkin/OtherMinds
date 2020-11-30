//Created 05/10/19
//Last updated 05/10/19

var gravMultiplier=dsin(global.gravdirection);

//This just plays through an animation and it should change the mask throughout
if (timeinstate==0)
	{
		image_index=0;
		//Sometimes the image_speed=-1 because of the ledge grab state reversing the animation
		image_speed=1;
		sprite_index=sprite_ledgeclimb;
	}

//When animation finishes, move coordinates and change state
if (image_index>image_number-0.5)
	{
		x+=ledgextranslation*directionfacing;
		y-=ledgeytranslation*gravMultiplier;
		//scr_snap_to_floor();
		//This is very important otherwise it does a spazzy flash frame at the wrong coordinates
		sprite_index=sprite_idle;
		mask_index=masknormal;
		state=PlayerState.idle;
		exit;
	}
	
//Now set the mask index - there is a new mask for every 2 subimages
mask_index=maskclimb[floor(image_index/2)];