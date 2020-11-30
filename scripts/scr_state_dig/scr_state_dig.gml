//Created 31/01/20
//Last updated 31/01/20 Why do I even write that anymore?

/*Anyway what's the plan boss man?
Check if we're above the ground, halt xspeed
We begin tunelling and increment our y by digspeed every frame
If we hit the bottom of the level, we turn around and go the other way
So we need digspeed and digdirection
Uh
That's it except sprite management
IMPORTANT THING HERE -> DON'T IGNORE!! ->Oh and don't explode the character if they're in dig mode
Other things - can't leave whilst in dig mode
Sound, can share with block pushing sound*/

//digstate stuff -1, just entered state, 0, predig, 1, dig, 2, postdig
if digstate=-1
	{
		sprite_index=sprite_predig;
		image_index=0;
		digstate=0
	}
if digstate=0 and image_index>image_number-1
	{
		sprite_index=sprite_digging;
		digstate=1;
		digdirection=pi*0.5;
		scr_play_sound(sound_dig,true,0);
		y+=1;
	}


if digstate=1
	{
		repeat (digspeed)
			{
				var ytarget=sin(digdirection);
				if bbox_bottom+ytarget>=room_height
					{
						digdirection=1.5*pi;
						ytarget=sin(digdirection);
					}
				if place_meeting(x,y+ytarget,obj_solid) or place_meeting(x,y+ytarget,obj_semisolid)
					{
						y+=ytarget;
					}
				else
					{
						y+=ytarget
						digstate=2;
						sprite_index=sprite_postdig;
						image_index=0;
						if ytarget<0
							{
								sprite_index=sprite_predig;
								image_index=image_number-1;
								image_speed=-1;
							}
						if soundplaying!=noone and audio_is_playing(soundplaying)
							{
								audio_stop_sound(soundplaying);
							}
						break;
					}
			}
		var dx=0;
		if (!position_meeting(bbox_left-2,y,obj_solid) and !position_meeting(bbox_left-2,y,obj_semisolid))
			{
				dx=1;
			}
		else if (!position_meeting(bbox_right+2,y,obj_solid) and !position_meeting(bbox_right+2,y,obj_semisolid))
			{
				dx=-1;
			}
		x+=dx;
	}

if digstate=2
	{
		var exitstate=false;
		if sprite_index=sprite_postdig and image_index>image_number-1
			{
				exitstate=true;
			}
		else if sprite_index=sprite_predig
			{
				image_speed=-1;
				if image_index<1
					{
						exitstate=true;
					}
			}
		//Go to idle and reset dig variables
		if exitstate=true
			{
				state=PlayerState.idle;
				digdirection=0.5*pi;
				digstate=-1;
			}
	}
	
if (digstate==1)
	{
		//Vibration
		var vib=(sin(timeinstate/3)*0.3+0.7);
		scr_set_vibration(vib,vib,1);
		//Particles (*irandom(1) increases probability of 0 particles emitted)
		var particleNum=irandom(3)*irandom(1);
		if (particleNum>0)
			part_particles_create(global.partSys,x,y,global.digParticle,particleNum);
	}