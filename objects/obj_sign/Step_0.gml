/// @description Movement and states
// You can write your code in this editor

// Inherit the parent event
event_inherited();

//exit if paused
if global.hardpause=1
	{
		image_speed=0;
		exit;
	}

scr_states_step();

//Also want to get you to reaad all dialogue at once
if (dialogueprevious==0)
	while(!dialoguecomplete)
		scr_dialoguemap_queue();

//Sprites for moving
if xspeed=0
	{
		image_index=0;
	}
else
	{
		image_index=1;
	}
	
/* This code makes the sign explode when you've talked to it about everything
I put this in because the signs got in the way after talking to them, but not a problem anymore
if (dialogueprevious==array_length_1d(text)-1 and ds_queue_empty(global.dialoguequeue)==true)
	{
		var xcentre=x+sprite_width*0.5;
		var ycentre=y+sprite_height*0.5;
		instance_create_layer(xcentre,ycentre,layer,obj_smoke);
		var emit=instance_create_layer(xcentre,ycentre,layer,obj_sound_emitter);
		emit.soundid=snd_pop;
		instance_destroy();
	}*/