/// @description

if activated=true
	{
		activated=false;
		with (parent_push)
			{
				x=xstart;
				y=ystart-32;
				instance_create_layer(x+sprite_width*0.5,y+sprite_height*0.5,layer,obj_smoke);
			}
	}