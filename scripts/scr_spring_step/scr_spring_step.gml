//Created: 14/07/19
//Last updated: 14/07/19

//This just manages animation
//The player will start the animation upon collision
event_inherited();

//Player will still bounce if soft paused
if (global.hardpause==true)
	{
		image_speed=0;
		exit;
	}

if (springing==true)
	{
		image_speed=1;
	}

//Play sound on frame 5
if (image_index==clamp(image_index,5,6) and canplaysound==true)
	{
		var emit=instance_create_layer(x,y,layer,obj_sound_emitter);
		emit.soundid=sound_spring;
		canplaysound=false;
	}
else if (image_index!=clamp(image_index,5,6))
	{
		canplaysound=true;
	}

if (image_index>image_number-1)
	{
		image_index=0;
		image_speed=0;
		springing=false;
	}