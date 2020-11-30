/// @description

var triggered=false;

if place_meeting(464,543,parent_push) and place_meeting(464,480,parent_push) and place_meeting(592,543,parent_push) and place_meeting(592,480,parent_push)
	{
		countdown=max(0,countdown-1);
		if countdown=0
			{
				triggered=true;
			}
	}
	
if keyboard_check_pressed(ord("G"))
	{
		triggered=true;
	}
	
if triggered=true
	{
		activated=true;
		audio_play_sound(snd_collect_animation,0,0);
		global.overworld_events=scr_event_set_complete(global.overworld_events,OVERWORLD_EVENTS.PUZZLECAVECOMPLETE);
		with (parent_push)
			{
				instance_create_layer(x+sprite_width*0.5,y+sprite_height*0.5,layer,obj_smoke);
				instance_destroy();
			}
		instance_activate_object(inst_63ABEAE2);
		instance_activate_object(inst_2430B276);
	}
	
if activated=true
	{
		global.softpause=true;
		var objtofollow=id;
		with (obj_camera)
			{
				if following=noone
					{
						following=objtofollow;
					}
			}
		if scr_on_camera()=false
			{
				exit;
			}
		else
			{
				alarm[0]=80;
				activated=false;
				global.overworld_events=scr_event_set_complete(global.overworld_events,OVERWORLD_EVENTS.PUZZLECAVECOMPLETE);
				scr_roomarray_set_secret_completed();
			}
	}