//Created 17/03/20
//Last updated 17/03/20

//disallowed state
if (state==PlayerState.defeated or state==PlayerState.dead or state==PlayerState.holding)
	exit;

//Handles all the conditions for whether you get hurt or not!!!
if (iframes==0 and canbehurtenabled==true)
	{
		iframes=61;
		var isMainCharacter=object_is_ancestor(object_index,parent_main_character);
		if (isMainCharacter or global.currentinstance==id)
			{
				scr_play_sound(sound_hurt,0,0);
				scr_set_vibration(1,1,10);
				instance_create_layer(x+sprite_width*0.5-sprite_xoffset,y-16,"Players",obj_brokenheart);
			}
		else
			scr_play_sound(snd_jumponenemy,0,0);

		if (isMainCharacter)
			global.Edhealth-=1;
			
		hp-=1;
	}