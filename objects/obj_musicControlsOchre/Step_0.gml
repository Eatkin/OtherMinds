/// @description

if (global.hardpause)
	{
		haspaused=true;
		exit;
	}
//Resync music
if (haspaused)
	{
		audio_sound_set_track_position(theMusic,(counter/60)+musicOffset);
		haspaused=false;
		audio_sound_gain(theMusic,global.music_volume*global.music_on,0);
	}

//timeline_position=counter;
counter+=1;
position=floor(counter/30);

if (counter>0 and counter==counter+counter%30 and audio_is_playing(theMusic))
	with (parent_main_character)
		instance_create_layer(x,y,layer,obj_quaver);

var player=parent_main_character;
//Stuff
switch (counter)	{
	case 30:
		with (obj_gauntlet_popoutspikes)
			if (x<=64)
				activated=true;
		break;
	case 60:
		with (obj_gauntlet_popoutspikes)
			if (x<=112)
				activated=true;
		break;
	case 90:
		with (obj_gauntlet_popoutspikes)
			if (x<=176)
				activated=true;
		break;
	case 120:
		with (obj_gauntlet_popoutspikes)
			if (x<=208)
				activated=true;
				
		if (player.x>192)	{
			scr_regionlock(192,0,true);
			locked[0]=true;
		}
			
		inst_37FBC94.activated=true;
		break;
	//Couple of extra checks for region locks
	case 180:
		if (player.x>192 and !locked[0])	{
			scr_regionlock(192,0,true);
			locked[0]=true;
		}
		break;
	case 240:
		if (player.x>192 and !locked[0])	{
			scr_regionlock(192,0,true);
			locked[0]=true;
		}
		break;
	case 450:
		//Toggle blocks
		audio_play_sound(snd_platform_tick,0,false);
		inst_5E5921FD.activated=true;
		break;
	case 458:
		//Toggle blocks
		audio_play_sound(snd_platform_tick,0,false);
		inst_5E5921FD.activated=true;
		break;
	case 465:
		//Toggle blocks
		audio_play_sound(snd_platform_tick,0,false);
		inst_5E5921FD.activated=true;
		break;
	case 473:
		//Toggle blocks
		audio_play_sound(snd_platform_tick,0,false);
		inst_5E5921FD.activated=true;
		break;
	case 480:
		//Toggle blocks
		audio_play_sound(snd_platform_tick,0,false);
		inst_5E5921FD.activated=true;
		scr_regionunlock();
		
		break;
	case 660:
		inst_CBB765A.activated=true;
		break;
	case 720:
		with (obj_gauntlet_popoutspikes)
			if (x==clamp(x,688,736))
				activated=true;
		with (obj_cannon)
			if (y==288)
				activated=true;
		break;
	case 990:
	case 1050:
	case 1110:
	case 1560:
		//Toggle blocks
		audio_play_sound(snd_platform_tick,0,false);
		inst_5E5921FD.activated=true;
		//Poop out spikes
		inst_3C0B17AC.activated=true;
		inst_47C6732E.activated=true;
		break;
	case 1500:
		//activate cannons
		inst_36820063.activated=true;
		inst_36820063.activated=true;
		if (player.x>992)
			scr_regionlock(992,512,true);
		break;
	case 1800:
		scr_regionunlock();
		break;
}