//Created 18/07/19
//Last updated 04/08/19

//This plays a sound but only if sound effects are turned on
//@param sound
//@param loops
//@param priority

//It might be worth having an audio init and update script for all sound emitting objects
//Then I can do 3d sound

//Anyway here I will set the volume based on distance to player
//I'll also set a slight variation in audio pitch
	
var pitchvariation=random_range(-0.05,0.05);

if global.sound_fx_on=0
	{
		exit;
	}

if argument0=noone
	{
		exit;
	}

//DO NOT play sound if we're too far away because otherwise it plays one fram
var player=global.currentinstance;
var dist=distance_to_object(player);
if dist>=falloffmax and id!=player
	{
		exit;
	}

//Set the volume
soundplaying=audio_play_sound_on(emitterid,argument0,argument1,argument2);
//Now the pitch
if (pitchoverride==1 and !instance_exists(obj_music_controls))
	{
		audio_sound_pitch(soundplaying,1+pitchvariation);
	}
else
	{
		audio_sound_pitch(soundplaying,pitchoverride);
	}
	
//Update volume because the inbuilt falloff is broken
//Calculate distances keeping bounding boxes in mind
var xdist;
var player=global.currentinstance;
if player.x=clamp(player.x,bbox_left,bbox_right)
	{
		xdist=0;
	}
else
	{
		xdist=min(abs(bbox_left-player.x),abs(bbox_right-player.x));
	}

var ydist;
if player.y=clamp(player.y,bbox_top,bbox_bottom)
	{
		ydist=0;
	}
else
	{
		ydist=min(abs(bbox_top-player.y),abs(bbox_bottom-player.y));
	}

var distancetolistener=sqrt(sqr(xdist)+sqr(ydist));

var gain;
if distancetolistener>=falloffmax
	{
		gain=0;
	}
else if distancetolistener<=falloffref
	{
		gain=1;
	}
else
	{
		gain=1-distancetolistener/falloffmax;
	}
	
if falloffmaxoverride!=0
	{
		if distancetolistener>=falloffmaxoverride
			{
				gain=0;
			}
		else if distancetolistener<=falloffmaxoverride/4
			{
				gain=1;
			}
		else
			{
				gain=1-distancetolistener/falloffmaxoverride;
			}
		
	}

gain=gain*global.sound_fx_volume*global.sound_fx_on*gainoverride;

audio_emitter_gain(emitterid,gain);

return soundplaying;