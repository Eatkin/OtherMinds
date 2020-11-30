/// @description

image_speed=0;

//if event complete
if (scr_inventory_check_quantity(obj_orb_white)>=42)
	{
		image_index=1;
		instance_create_layer(x,y,layer,obj_block);
		with (global.currentinstance)
			scr_todo_complete(2);
	}