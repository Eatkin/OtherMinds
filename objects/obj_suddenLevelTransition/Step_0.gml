/// @description

if (place_meeting(x,y,parent_main_character) and active==false)
	{
		active=1;
		global.softpause=true;
		transitionobject=scr_create_transition(0,TRANSITION.BLOCK_IN);
		
		if (room==room_EdSpace1_7 or room==rm_EdSpace1_6 or room==rm_EdSpace2_6)
			{
				scr_set_vibration(1,1,30);
				var snd=audio_play_sound(snd_cannon_into_wall,0,0);
				audio_sound_gain(snd,global.sound_fx_volume*global.sound_fx_on,0);
			}
	}
if (active==true)
	{
		if (transitionobject.transitioncomplete==true)
			{
				instance_destroy(transitionobject);
				room_goto(destination);
			}
	}