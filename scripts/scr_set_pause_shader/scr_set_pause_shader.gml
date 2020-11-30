//Created 18/07/19
//Last updated 16/11/19

//This applies the brightness shader which has greyscale mode inbuilt and will set it to greyscale when global.hardpause=1	
shader_set(shd_brightness);
var b=shader_get_uniform(shd_brightness,"brightness");
var bright=global.brightness;
if instance_exists(obj_darkness)
	{
		bright=bright*obj_darkness.darknessmultiplyer;
	}
shader_set_uniform_f(b,bright);
var greyscale=shader_get_uniform(shd_brightness,"greyscale");
shader_set_uniform_f(greyscale,global.hardpause);