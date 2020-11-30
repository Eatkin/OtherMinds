/// @description

// Inherit the parent event
event_inherited();

if (global.hardpause==true)
	{
		image_speed=0;
		exit;
	}

if (activated==true)
	{
		global.officeevents=scr_event_set_complete(global.officeevents,OFFICEEVENTS.COLLAPSEDFLOOR)
		if (delay==-1)
			{
				delay=irandom(maxdelay);
				exit;
			}
		else if (delay>0)
			{
				delay-=1;
				exit;
			}
		if (soundplaying==noone)
			{
				scr_play_sound(snd_shake,false,0);
			}
		image_speed=1;
		if (image_index>7 and instance_exists(myBlock))
			{
				instance_destroy(myBlock);
			}
		else if (irandom(5)==0)
			{
				{
					var xx=random(sprite_width);
					part_particles_create(global.partSys,x+xx,y,global.crumbleParticle,1);
				}
			}
		if (image_index>image_number-1)
			{
				instance_destroy();
			}
	}