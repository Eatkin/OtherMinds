/// @description

// Inherit the parent event
event_inherited();

//Complete the defeated boss event
global.edspaceevents_one=scr_event_set_complete(global.edspaceevents_one,EVENTS_EDSPACE_ONE.BOSSDEFEATED);

if scr_event_check_complete(global.edspaceevents_one,EVENTS_EDSPACE_ONE.COLLECTEDMASTERPLAN)=0 and !instance_exists(obj_masterplan)
	{
		//Eject the master plan
		instance_create_layer(x,y,"objects",obj_masterplan);
		scr_inventory_remove(obj_masterplan,localinventory);
	}