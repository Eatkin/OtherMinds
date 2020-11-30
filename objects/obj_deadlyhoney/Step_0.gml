/// @description

if global.hardpause=true
	{
		image_speed=0;
		exit;
	}
else
	{
		image_speed=1;
	}

if (y<room_height and instance_exists(hurtmask))
	{
		var xwidth=xbound[1]-xbound[0];
		scr_object_resize(hurtmask,xwidth,room_height-y);
		hurtmask.y=bbox_top;
	}