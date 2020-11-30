//Created 01/08/19
//Last updated 01/08/19


if global.currentinstance!=id
	{
		exit;
	}
//Just making this script so I can make minor modifications to spawn conditiosn
//Eg I might want to set it so Sage can't' spawn outside the room (I do want to do that)
var _x=x+sprite_width/2-sprite_xoffset;
var _y=y+sprite_height/2-sprite_yoffset;

if argument_count>0
	{
		_x=argument[0];
		_y=argument[1];
	}

//Exit conditions if created outside room
if _x!=clamp(_x,0,room_width)
	{
		scr_play_sound(snd_sage_nope,false,0);
		exit;
	}
if _y!=clamp(_y,0,room_height)
	{
		scr_play_sound(snd_sage_nope,false,0);
		exit;
	}

//adjust _x and _y incase we will get lodged in a block
var sage=instance_create_layer(_x,_y,"Players",obj_sage);
global.currentinstance=sage;
return sage;