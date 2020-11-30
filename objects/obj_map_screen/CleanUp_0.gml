/// @description Insert description here
// You can write your code in this editor

ds_grid_destroy(themap);
ds_grid_destroy(connections);

if surface_exists(mapsurf)
	{
		surface_free(mapsurf);
	}
	
if (audio_is_playing(panning_sound))
	{
		audio_stop_sound(panning_sound);
	}