/// @description alter fog and stuff

event_inherited();

if global.hardpause=true
	{
		exit;
	}

shadertimer+=1;

//Just mark the shower as on and chagne the label when we turn it on, opposite for turning it off
if active=true
	{
		active=false;
		showeron=showeron^1;
		if showeron=true
			{
				label=scr_return_text(247);
			}
		else
			{
				label=scr_return_text(246);
			}
	}
	
//Now actual shower behaviour for when its turned on or off
if showeron=true
	{
		showertimer+=1;
		fogalpha=lerp(fogalpha,maxfogalpha,0.001);
		if soundplaying=noone
			{
				scr_play_sound(shower_sound,true,0);
			}
	}
else if fogalpha!=0
	{
		//Lerp towards zero
		fogalpha=lerp(fogalpha,0,0.01);
		showertimer+=1;
	}

if showeron=false and soundplaying!=noone
	{
		audio_stop_sound(soundplaying);
		soundplaying=noone;
	}

//Set steam alpha to 0 and showertimer to 0
if fogalpha<0.01 and showeron=false
	{
		fogalpha=0;
		showertimer=0;
	}

//Set the shower image index
showerimg+=0.25;
showerimg=showerimg%8;