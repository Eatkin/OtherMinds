/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if global.hardpause=1
	{
		image_speed=0;
		exit;
	}

var player=instance_place(x,y,parent_main_character);
if player!=noone
	{
		if scr_inventory_check(obj_lime_key) and open=0
			{
				scr_roomarray_set_secret_completed();
				global.ochre_events=scr_event_set_complete(global.ochre_events,OCHRE_EVENTS.UNLOCKED_DOOR);
				var door=instance_create_layer(x,y,layer,obj_door);
				door.destination=mydestination; //Let's set a temp destination to next room
				door.sprite_index=spr_ochrehilldoor;
				open=true;
				scr_play_sound(snd_door_unlock,false,0);
			}
	}
	
//Treasure map
var block=instance_place(x,y,parent_push)
if block!=noone
	{
		var touchingfloor=false;
		with (block)
			{
				if place_meeting(x,y+1,obj_solid) and state!=PlayerState.beingcarried
					{
						touchingfloor=true;
					}
			}
		if touchingfloor=true
			{
				if block=inst_5965CE5B
					{
						if scr_event_check_complete(global.ochre_events,OCHRE_EVENTS.TREASURE_MAP)=false and treasuremapcreated=false
							{
								//Create treasure map here!
								//If you don't collect it you just have to do it again
								instance_create_layer(x-128,-64,"objects",obj_treasure_map_2);
								treasuremapcreated=true;
								global.ochre_events=scr_event_set_complete(global.ochre_events,OCHRE_EVENTS.TREASURE_MAP)
							}
					}
				else
					{
						instance_create_layer(block.x+block.sprite_width,block.y+block.sprite_height,layer,obj_smoke);
						instance_destroy(block);
						scr_queue_dialogue_box(scr_return_text(363));
						obj_dialogue.x=x+sprite_width*0.5;
						obj_dialogue.y=y+sprite_height*0.5;
					}
			}
	}
	
//Image speed selection
if open=1 and image_index<image_number-1
	{
		image_speed=1;
	}
else
	{
		image_speed=0;
	}