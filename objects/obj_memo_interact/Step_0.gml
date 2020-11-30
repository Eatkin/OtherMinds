/// @description

// Inherit the parent event
event_inherited();

if (active==true)
	{
		if (scr_event_check_complete(global.officeevents,OFFICEEVENTS.MEMO_COLLECTED)==false)
			{
				var player=parent_main_character;
				instance_create_layer(player.x,player.y,layer,obj_memo_collect);
				global.officeevents=scr_event_set_complete(global.officeevents,OFFICEEVENTS.MEMO_COLLECTED);
				visible=false;
				exit;
			}
		if (parent_main_character.state!=PlayerState.holding and !instance_exists(obj_memo_collect))
			{
				//Complete the dig up dirt event IF discovered
				if (scr_todo_checkDiscovered(16))
					scr_todo_complete(16);
					
				//New events - take note to new deal
				scr_todo_discover(25);
					
				with (obj_collapsing_floor)
					{						
						activated=true;
					}
				instance_destroy();
			}
	}