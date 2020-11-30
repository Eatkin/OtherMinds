/// @description Insert description here
// You can write your code in this editor

event_inherited();

if (activated==true)
	{
		instance_create_layer(x,y,layer,obj_block_off);
		instance_destroy();
	}