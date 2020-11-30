/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if global.hardpause=1
	{
		image_speed=0;
		scr_pause_alarms();
		exit;
	}
else
	{
		image_speed=1;
	}

//Flash towards end of life
if alarm[0]<21
	{
		if alarm[0]%5=0
			{
				visible=visible^1;
				if visible=1
					{
						scr_play_sound(snd_barrier_destroy,false,0);
					}
			}
	}
	
if alarm[1]!=-1
	{
		var distance=distance_to_object(global.currentinstance);
		var mindist=64;
		var maxdist=512;
		var shake=3;
		if distance>mindist
			{
				shake*=(maxdist-distance)/(maxdist-mindist);
			}
		//scr_camera_screenshake_x(3);
		scr_camera_screenshake_y(shake);
		scr_set_vibration(min(1,shake),min(1,shake),10);
	}

if alarm[0]!=-1 and instance_exists(emit)
	{
		var _gain=emit.gainoverride;
		_gain=lerp(_gain,0,0.18);
		emit.gainoverride=_gain;
	}
	

//Update emitter position
if instance_exists(emit)
	{
		var player=global.currentinstance;
		emit.x=player.x;
		emit.y=player.y;
		emit.x=clamp(emit.x,bbox_left,bbox_right);
		emit.y=clamp(emit.y,bbox_top,bbox_bottom);
	}