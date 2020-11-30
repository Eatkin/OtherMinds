//Created 20/08/19
//Last updated 20/08/19

//Resizes object to specified width and height
//That was really easy

var obj=argument0;
var width=argument1;
var height=argument2;

with (obj)
	{
		image_xscale=1;
		image_yscale=1;
		image_xscale=width/sprite_width;
		image_yscale=height/sprite_height;
	}
	
return obj;