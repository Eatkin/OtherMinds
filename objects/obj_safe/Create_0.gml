/// @description

event_inherited();

label=scr_return_text(248);
active=false;

if scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.OPENEDSAFE)=true
	{
		instance_create_layer(x,y,layer,obj_safe_dud);
		//Check if we have the key in our inventory and if we don't, create it
		if scr_inventory_check(obj_cellar_key)=false
			{
				instance_create_layer(x,y,layer,obj_cellar_key);
			}
		instance_destroy();
	}