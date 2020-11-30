/// @description Exit
// You can write your code in this editor

if global.debugging=false
	{
		exit;
	}

if (keyboard_check(ord("A")))
	{
		game_end();
	}