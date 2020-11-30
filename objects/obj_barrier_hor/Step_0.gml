/// @description Control colours and state
// You can write your code in this editor

event_inherited();

if global.hardpause=1
	{
		image_speed=0;
		scr_pause_alarms();
		exit;
	}
else
	{
		image_speed=1;
	}

//Collission with Ed
var playablecharacter=global.currentinstance;
if playablecharacter.object_index=obj_sage
	{
		playablecharacter=parent_main_character;
	}

if state=BARRIER.NORMAL
	{
		if distance_to_object(playablecharacter)<distance_to_object(obj_sage)
			{
				instance_deactivate_object(myblock);
			}
		else
			{
				instance_activate_object(myblock);
			}
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

if (place_meeting(x,y,playablecharacter) or place_meeting(x,y,parent_possessable)) and state=BARRIER.NORMAL
	{
		state=BARRIER.DISAPPEAR;
		global.hint_events=scr_event_set_complete(global.hint_events,EVENTS_HINTS.SAGE_BARRIER);
		alarm[0]=flashtime;
		scr_barriermap_setdeactivated();
		instance_destroy(myblock);
	}

//Now collission with Sage
//This is really finicy because this barrier doesn't have a collission box
//So I've got to see if Sage is in the barrier then shove him out in the direction he entered
if instance_exists(obj_sage)
	{
		var dist=max(0,distance_to_object(obj_sage)-obj_sage.sprite_width/2);
		hueshift=1-min(dist/128,1);
	}
else
	{
		hueshift=0;
	}

var dist=max(0,distance_to_object(playablecharacter)-playablecharacter.sprite_width/2);
satshift=1-min(dist/128,1);