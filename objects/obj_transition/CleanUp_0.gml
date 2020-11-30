/// @description Free surface
// You can write your code in this editor

//Unpause but only if we aren't displaying dialogue
global.softpause=0;
if surface_exists(transitionsurface)
	{
		surface_free(transitionsurface);
	}