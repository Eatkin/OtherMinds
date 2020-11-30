/// @description Image_speed based on alarm
// You can write your code in this editor

// Inherit the parent event
event_inherited();

//Dear Past Ed,
//Thanks for commenting this, jackass
//From,
//Future Ed

if global.hardpause=1
	{
		image_speed=0;
		scr_pause_alarms();
		exit;
	}

//This is the flashing phase where it flashes on and off
if alarm[0]>0
	{
		if 40/alarm[0]=round(40/alarm[0])
			{
				//audio_stop_sound(snd_laser_precharge);
				scr_play_sound(snd_laser_precharge,false,0);
			}
		image_speed=2-alarm[0]/60;
	}
else if alarm[1]>0
	{
		//Charging
		image_speed=1;
	}
else
	{
		image_speed=0;
	}
	
if mysmoke!=noone
	{
		mysmoke.x=x;
	}
	
if mylaser=noone
	{
		if alarm[1]>0
			{
				sprite_index=spr_laser_cannon_charging;
			}
		else
			{
				sprite_index=spr_laser_cannon;
			}
	}
else
	{
		sprite_index=spr_laser_cannon_firing;
	}
	
if shots=0 and alive=1
	{
		with (obj_boss_controller)
			{
				lasersdestroyed+=1;
			}
		alive=0;
		mysmoke=instance_create_layer(x+4,y,"objects",obj_smoke_billowing);
		mysmoke.layer=layer_get_id("objects");
		mysmoke.depth-=1;
	}