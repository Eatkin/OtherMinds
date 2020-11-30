/// @description Insert description here
// You can write your code in this editor

event_inherited();

//Idk what this does, it's to keep time in the rhythm levels
if (global.hardpause or !activated)	{
		if (instance_exists(obj_persistentCannonTimer) and !activated)
			timer=0;
		exit;
	}
	
if (instance_exists(obj_transition))
	if (!activated and !instance_exists(obj_persistentCannonTimer))	{
			timer=0;
			exit;
		}

if (round(timer)%round(firerate)==0)
	{
		if (room==rm_ochrehill_6 and global.rng==0)
			{
				var bullet=instance_create_layer(x,y,"objects",obj_beeball);
				bullet.image_xscale=-image_xscale;
			}
		else		//Create ball
			var bullet=instance_create_layer(x,y,"objects",obj_cannon_ball);
		bullet.xspeed=-3*image_xscale;
		bullet.image_angle=image_angle;
		var smokeRing=instance_create_layer(x,y,"objects",obj_smokering);
		smokeRing.image_angle=image_angle;
		var snd=snd_bullet_fire;
		scr_play_sound(snd,false,0);
		//Facing up and down, yeah okay I did it really lazily
		if (image_angle!=0)
			bullet.xspeed=0;
		if (abs(image_angle)==90)
			bullet.yspeed=-3*image_xscale;		//Naive method, if image_angle=-90 this needs to be multiplied by dsin(image_angle) - so if you're wondering why it doesn't work, that's why :)
	}
timer+=1;