/// @description

image_speed=0;

if (scr_inventory_check_quantity(obj_orb_green)>=50)
	{
		image_index=1;
		instance_create_layer(x,y,layer,obj_block);
	}