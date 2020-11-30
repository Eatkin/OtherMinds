/// @description Destroy inventory grid (and local todo)
// You can write your code in this editor

event_inherited();

if (object_get_parent(object_index)==parent_main_character)
	exit;

if ds_exists(localinventory,ds_type_grid)
	{
		ds_grid_destroy(localinventory);
	}
if ds_exists(localtodo,ds_type_grid)
	{
		ds_grid_destroy(localtodo);
	}