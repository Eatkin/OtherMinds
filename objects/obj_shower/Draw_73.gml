/// @description draws the fog

if fogalpha=0
	{
		exit;
	}


gpu_set_blendmode(bm_add);

/*shader_set(shd_wavy);

var amp=0.0002;
var freq=1/amp;
shader_set_uniform_f(f,freq);
shader_set_uniform_f(a,amp);
shader_set_uniform_f(s,freq);
shader_set_uniform_f(t,1);*/

shader_set(shd_ripple);
var amp=0.0002;
var freq=1/amp;
shader_set_uniform_f(f,freq);
shader_set_uniform_f(a,amp);

//Draw the fog
for (var i=0; i<3; i+=1)
	{
		shader_set_uniform_f(t,shadertimer+sqr(i));
		//shader_set_uniform_f(t,0.1*amp*(shadertimer+sqr(i)));
		var _x=steam[i].x;
		var _y=steam[i].ystart+dsin(showertimer+45*i);
		var _spr=steam[i].sprite_index;
		draw_sprite_ext(_spr,0,_x,_y,1,1,0,c_white,fogalpha);
	}

shader_reset();
gpu_set_blendmode(bm_normal);