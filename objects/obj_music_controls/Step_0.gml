/// @description

if (global.hardpause==true)
	{
		haspaused=true;
		exit;
	}
//Resync music
if (haspaused==true)
	{
		audio_sound_set_track_position(theMusic,(counter/60)+musicOffset);
		haspaused=false;
		audio_sound_gain(theMusic,global.music_volume*global.music_on,0);
	}

timeline_position=counter;
counter+=1;
position=floor(counter/30);

if (audio_is_playing(theMusic) and counter>0 and counter==counter+counter%30)
	with (parent_main_character)
		instance_create_layer(x,y,layer,obj_quaver);