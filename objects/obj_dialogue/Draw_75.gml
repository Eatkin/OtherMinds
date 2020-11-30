/// @description Draws the text
// You can write your code in this editor

if global.brightness!=1
	{
		shader_set(shd_brightness);
		var b=shader_get_uniform(shd_brightness,"brightness");
		shader_set_uniform_f(b,global.brightness);
		var greyscale=shader_get_uniform(shd_brightness,"greyscale");
		shader_set_uniform_f(greyscale,0);
	}

scr_show_dialogue_box();

if global.brightness!=1
	{
		shader_reset();
	}