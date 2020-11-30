/// @description Draw the lighting

gpu_set_blendmode(bm_add);
draw_sprite_ext(sprite_index,-1,x,y,1,1,0,colour,alpha);
gpu_set_blendmode(bm_normal);