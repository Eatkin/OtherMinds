/// @description

//There's only ever going to be parent main character+sage on screen so lets draw Ed then draw Sage if he exists
draw_self();
//Actually draw Sage first, because he's infront of the player so he'd be behind in the mirror
//No its the other way round
var player=parent_main_character;

//Amounts to translate the coordinates by
var xtrans=-4;
var ytrans=-4;

//I have no idea how this works but it works perfectly
if player.x=clamp(player.x,bbox_left-16,bbox_right+16)
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


//Now we draw the fog in the mirror based on how long the shower has been on
var alphatarget=0;
var _shower=0;
_shower=obj_shower.showertimer;
var alphamax=0.3

if _shower>180
	{
		alphatarget=alphamax;
	}
else
	{
		alphatarget=0;
	}

fogalpha=lerp(fogalpha,alphatarget,0.01);
//Set secret complete
//ASSOCIATE AN EVENT WITH THIS SO IT DOESN'T CONTINUALLY SET SECRETS COMPLETE!!s
if fogalpha>alphamax/2 and scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.SHOWERSECRET)=false
	{
		scr_roomarray_set_secret_completed();
		global.edhouse_events=scr_event_set_complete(global.edhouse_events,EVENTS_EDHOUSE.SHOWERSECRET);
	}
if abs(fogalpha-alphatarget)<0.01
	{
		fogalpha=alphatarget;
	}
	
//Draw a foggy mirror texture and then the fogged up mirror
gpu_set_blendmode(bm_add);
draw_sprite_ext(spr_normalmirror,0,x,y,1,1,0,c_white,alphamax-fogalpha);
draw_sprite_ext(spr_foggedupmirror,0,x,y,1,1,0,c_white,fogalpha);
gpu_set_blendmode(bm_normal);