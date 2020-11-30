/// @description States and stuff
// You can write your code in this editor

event_inherited();

if (instance_exists(obj_transition))
	{
		exit;
	}

scr_states_step();

//Sounds
var destroyemitter=false;
if (global.hardpause==true)
	{
		scr_pause_alarms();
		destroyemitter=true;
	}

//Alright the problem here is I'm guessing the sound registers as not playing if it has a gain of 0
if (!instance_exists(soundemitter))
	{
		soundemitter=noone;
	}
if ((state==PlayerState.air or state==PlayerState.carrying) and destroyemitter==false)
	{
		if (soundemitter==noone)
			{
				soundemitter=instance_create_layer(x,y,"objects",obj_sound_emitter);
				soundemitter.mode=EMITTER.LOOP;
				soundemitter.soundid=sound_flap;
				soundemitter.pitchoverride=0.5;
			}
		else
			{
				soundemitter.x=x;
				soundemitter.y=y;
			}
	}
else
	{
		destroyemitter=true;
	}

if (destroyemitter==true)
	{
		if (soundemitter!=noone)
			{
				instance_destroy(soundemitter);
				soundemitter=noone;
			}
	}

if flyingtoeggbert=true
	{
		var eggbert=obj_eggbert_hatched;
		if !place_meeting(x,eggbert.y,eggbert)
			{
				s_hinput=sign(eggbert.x-x);
			}
		if state!=PlayerState.air and timeinstate>1
			{
				flyingtoeggbert=false;
				alarm[0]=30;				
			}
	}