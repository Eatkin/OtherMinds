/// @description

if (staticTimer>0)
	{
		shader_set(shd_noise);
		var _t=shader_get_uniform(shd_noise,"time");
		shader_set_uniform_f(_t,random(1));
	}
	
draw_sprite(tvSprite,0,x,y);

if (staticTimer>0)
	{
		shader_reset();
	}

draw_sprite(sprite_index,0,x,y);