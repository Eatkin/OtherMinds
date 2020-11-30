/// @description

//There's only ever going to be parent main character+sage on screen so lets draw Ed then draw Sage if he exists
draw_self();
//Actually draw Sage first, because he's infront of the player so he'd be behind in the mirror
//No its the other way round

//Amounts to translate the coordinates by
var xtrans=-4;
var ytrans=-4;

var playernum=instance_number(parent_main_character);
for (var i=0; i<playernum; i+=1)
	{
		var player=instance_find(parent_main_character,i);
		if (player.x==clamp(player.x,bbox_left-16,bbox_right+16))
			{
				var spr=player.sprite_index;
				var img=player.image_index;
				var _xscale=player.image_xscale;
				var _yscale=player.image_yscale;
				var _x=player.x+xtrans-sprite_get_xoffset(spr)*_xscale;
				var _y=player.y+ytrans-sprite_get_yoffset(spr);
				var left=0;
				var width=sprite_get_width(spr);
				var top=max(0,y-_y); 
				var height=sprite_get_height(spr);
				draw_sprite_part_ext(spr,img,left,top,width,height,_x+left,_y+top,_xscale,_yscale,c_white,1);
			}
	}
	
if instance_exists(obj_sage)
	{
		var sage=obj_sage;
		if sage.x=clamp(sage.x,bbox_left-16,bbox_right+16)
			{
				var spr=sage.sprite_index;
				var img=sage.image_index;
				var _xscale=sage.image_xscale;
				var _yscale=sage.image_yscale;
				var _x=sage.x+xtrans-sprite_get_xoffset(spr)*_xscale;
				var _y=sage.y+ytrans-sprite_get_yoffset(spr);
				var left=0;
				var width=sprite_get_width(spr);
				var top=max(0,y-_y);
				var height=sprite_get_height(spr);
				draw_sprite_part_ext(spr,img,left,top,width,height,_x+left,_y+top,_xscale,_yscale,c_white,1);
			}
	}
	
//Draw a foggy mirror texture
gpu_set_blendmode(bm_add);
draw_sprite_ext(spr_normalmirror,0,x,y,image_xscale,image_yscale,0,c_white,0.2);
gpu_set_blendmode(bm_normal);