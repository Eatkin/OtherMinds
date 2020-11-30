/// @description

image_speed=0;
var quant=27;

//quant=0;		//Manual override

if (scr_inventory_check_quantity(obj_orb_red)>=quant)
	{
		image_index=1;
		instance_create_layer(x,y,layer,obj_block);
	}