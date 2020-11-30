//Created 13/07/19
//Last updates 24/07/19

if backgroundnumber=0
	{
		exit;
	}

var darknessShader=(canBeDark and scr_isDark() and darknessShaderValue!=1) ? true : false;

if (darknessShader)
	{
		shader_set(shd_brightness);
		var b=shader_get_uniform(shd_brightness,"brightness");
		shader_set_uniform_f(b,darknessShaderValue);
		var greyscale=shader_get_uniform(shd_brightness,"greyscale");
		shader_set_uniform_f(greyscale,false);
	}	

var i;
for (i=0;i<backgroundnumber;i+=1)
	draw_sprite_tiled(background[i],-1,backgroundx[i],backgroundy[i]);

if (darknessShader)
	shader_reset();