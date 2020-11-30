/// @description

// Inherit the parent event
event_inherited();

ds_list_destroy(_list);

if (myEmitter!=noone)
	instance_destroy(myEmitter);