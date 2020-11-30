/// @description States and stuff
// You can write your code in this editor

event_inherited();

//Augustus is largely the same except he cannot be killed and he talks to you and he doesn't attack you

//exit if paused -Although this is built in we have additional code so its necessary
if global.hardpause=1
	{
		image_speed=0;
		exit;
	}
image_speed=1;
	
scr_states_step();

//Splat on the floor and drop the keys if player throws Augustine off a cliff
if state=PlayerState.splat and y>ystart+16 and scr_event_check_complete(global.edspaceevents_one,EVENTS_EDSPACE_ONE.COLLECTEDGREENKEY)=0 and !instance_exists(obj_key_green)
	{
		scr_todo_fail(0,localtodo);
		instance_create_layer(x,y,layer,obj_key_green);
		scr_inventory_remove(obj_key_green,localinventory);
	}
//Now we give Augustus his dialogue
//We include an extra dialogue if he's been thrown off a cliff
#region obselete
/*
if (y>ystart and dialogueread<2 and room!=room_EdSpace1_7)
	{
		dialoguecomplete=false;
	}*/
#endregion

//Add 16 because (s)he snaps to the floor
if (y>ystart+16 and thrownoffcliff==false and room!=room_EdSpace1_7)
	{
		//Load the new dialogue if thrown off a cliff
		thrownoffcliff=true;
		scr_dialoguemap_init(5,6);
	}
	
//Outside room
if state=PlayerState.defeated
	{
		x=xstart;
		y=ystart;
		state=PlayerState.idle;
	}
	
//Augustine's behaviour
//He's really easy. Wake up and face the player is all that's necessary

if global.currentinstance=id
	{
		if (scr_event_check_complete(global.hint_events,EVENTS_HINTS.VIEWINVENTORY)==false)
			{
				scr_queue_notification(scr_return_text(402),NOTIFICATION.HINT);
				global.hint_events=scr_event_set_complete(global.hint_events,EVENTS_HINTS.VIEWINVENTORY);
			}
		exit;
	}
	
//This is it, so simple
var player=instance_nearest(x,y,parent_main_character);
var xdist=abs(player.x-x);
if xdist<global.talkdistance+64 and distance_to_object(player)<global.talkdistance+128
	{
		//We do timeinstate=0 because we get stuttering when it tries to go to waiting
		timeinstate=0;
		waiting=0;
		directionfacing=scr_sign_nonzero(player.x-x);
	}