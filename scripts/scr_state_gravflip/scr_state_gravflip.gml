//created 22/06/20
//last updated 22/06/20

//This literally just plays an animation then flips gravity

if (sprite_index!=sprite_gravityFlip)
	{
		sprite_index=sprite_gravityFlip;
		image_index=0;
		scr_play_sound(snd_jump,false,0);
	}
	
if (image_index>image_number-0.5)
	{
		state=PlayerState.air;
		scr_gravityInvert();
	}