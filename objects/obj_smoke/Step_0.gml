/// @description Destroy at animation end
// You can write your code in this editor

if (global.hardpause==true)
	{
		image_speed=0;
	}
else
	{
		image_speed=1;
	}

if (image_index>image_number-0.5)
	{
		instance_destroy();
	}