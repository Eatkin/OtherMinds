/// @description States and stuff
// You can write your code in this editor

event_inherited();

scr_states_step();

//Behaviour
if (global.currentinstance==id)
	{
		exit;
	}

directionfacing=scr_sign_nonzero(global.currentinstance.x-x);

var dialogueempty=ds_queue_empty(global.dialoguequeue);

//We need to talk to Big Slime at least once to give him the grappa
//This handles the grappa event AND giving him the grappa
if (dialogueempty==false)
	{
		if (scr_inventory_check(obj_grappa))
			{
				instance_create_layer(x,y,layer,obj_granite_surface);
				scr_inventory_remove(obj_granite_surface,localinventory);
				//Todo and events
				scr_todo_complete(0,localtodo);
				global.edhouse_events=scr_event_set_complete(global.edhouse_events,EVENTS_EDHOUSE.GRAPPA);
				with (global.currentinstance)
					{
						scr_todo_complete(11);
					}
				scr_inventory_remove(obj_grappa);
				scr_inventory_add(obj_grappa,localinventory);
			}
		with (global.currentinstance)
			{
				scr_todo_discover(11);
			}
	}