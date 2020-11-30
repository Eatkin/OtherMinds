/// @description

if (global.hardpause==true)
	{
		exit;
	}

if (activated==true)
	{
		var player=parent_main_character;
		var xtarget=player.x-sprite_width*0.5;
		x=lerp(x,xtarget,0.5);
		x=clamp(x,416,704);
	}