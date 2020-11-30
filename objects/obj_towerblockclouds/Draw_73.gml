/// @description

gpu_set_blendmode(bm_add);
shader_set(shd_ripple);
var amp=0.0002;
amp=0.0004;
var freq=1/amp;
shader_set_uniform_f(f,freq);
shader_set_uniform_f(a,amp);

shader_set_uniform_f(t,shadertimer);
var _spr=sprite_index;
draw_sprite_ext(_spr,0,x,y,1,1,0,c_white,0.8);

shader_reset();
gpu_set_blendmode(bm_normal);