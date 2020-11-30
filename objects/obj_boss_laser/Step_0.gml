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

if state=BARRIER.DISAPPEAR
	{
		instance_deactivate_object(myblock);
	}
else
	{
		instance_activate_object(myblock);
	}
	
if state=BARRIER.REAPPEAR and sound_emitter=noone
	{
		//Create a sound emitter
		sound_emitter=instance_create_layer(x,y,layer,obj_barrier_sound);
		sound_emitter.owner=id;
	}
	
//Rumble
if state=BARRIER.NORMAL
	{
		var vibamount;
		var dist=distance_to_object(global.currentinstance);
		var maxdist=128;
		vibamount=1-min(1,dist/maxdist);
		if vibamount>0.5
			{
				vibamount=clamp(vibamount,0.5,0.8);
				scr_set_vibration(vibamount,vibamount,1);
			}
	}
	
visiblecounter+=1;
if visiblecounter%2=0
	{
		alpha=0.75-(alpha-0.5);
	}