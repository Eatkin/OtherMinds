/// @description Insert description here
// You can write your code in this editor

var snd=noone;

if global.inputs[15]=1 or global.inputs[14]=1 or global.inputs[5]=1
	{
		moveenabled=0
		movedir=-movedir;
		snd=audio_play_sound(snd_menu_shift,0,0);
		audio_sound_gain(snd,global.sound_fx_volume*global.sound_fx_on,0);
		if movedir=-1
			{
				audio_sound_pitch(snd,0.9);
			}
	}

//Grab inputs
var hinput=0;
var vinput=0;

//Inputs not accepted if binding a key or loading a game
if moveenabled=1
	{
		hinput=global.inputs[0];
		vinput=global.inputs[1];
	}

var normalise=max(1,sqrt(sqr(abs(sign(hinput)))+sqr(abs(sign(vinput)))));
hinput=hinput/normalise;
vinput=vinput/normalise;

//Pan the camera
camx+=hinput*5;
camy-=vinput*5;

//Clamp the camera
camx=clamp(camx,0,surface_get_width(mapsurf)-guiwidth);
camy=clamp(camy,0,surface_get_height(mapsurf)-guiheight);


//Set the gain of the panning sound based on input
var pitchtarget=abs(hinput)+abs(vinput);
var pitch=audio_sound_get_pitch(panning_sound);
pitch=lerp(pitch,pitchtarget,0.2);
if pitch<0.01
	{
		pitch=0;
	}
if pitch>0.99
	{
		pitch=1;
	}
	
if audio_is_playing(panning_sound)
	{
		audio_sound_pitch(panning_sound,pitch);
	}