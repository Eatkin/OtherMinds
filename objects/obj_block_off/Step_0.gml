/// @description Insert description here
// You can write your code in this editor

if activated=1
	{
		//Don't change until the place is free'd - this early exits the script if someone is wedge in a block
		var player=instance_place(x,y,parent_possessable);
		if player=noone
			{
				player=instance_place(x,y,obj_sage);
			}
		if player=noone
			{
				player=instance_place(x,y,parent_push);
			}
		if player!=noone
			{
				exit;	
			}
		instance_create_layer(x,y,layer,obj_block_on);
		instance_destroy();
	}