/// @description Creation code
// You can write your code in this editor

event_inherited();

scr_intrinsic_variables(scr_return_text(391),0,0,0,0,0,1,true,0);
scr_modules_init();
scr_bio(scr_return_text(392), scr_return_text(393),sprite_index);

state=PlayerState.idle;

sprite_idle=sprite_index;
sprite_blink=spr_justin_blink;

talkenabled=true;
xscaleflipenabled=false;
moveenabled=false;
gravityenabled=false;
blinkingenabled=true;

text[0]=scr_return_text(394);
text[1]=scr_return_text(395);
text[2]=scr_return_text(396);
text[3]=scr_return_text(397);
text[4]=scr_return_text(854);
text[5]=scr_return_text(397);

var _min=0;
var _max=1;

myblock=instance_create_layer(bbox_right-4,bbox_top,layer,obj_block);
//These are for when we're in wall fall state and want to play some sounds
soundplayed[0]=false;
soundplayed[1]=false;
if (scr_event_check_complete(global.ochre_events,OCHRE_EVENTS.JUSTIN_WALLED)==true)
	{
		instance_destroy(myblock);
		myblock=noone;
		sprite_idle=spr_justin_idleexploded;
		sprite_blink=spr_justin_blinkexploded;
		sprite_index=sprite_idle;
		image_index=image_number-1;
		image_speed=0;
		mask_index=spr_justin_exploded_mask;
		masknormal=mask_index;
		_min=2;
		_max=3;
	}
	
if (scr_event_check_complete(global.globalevents,EVENTS_GLOBAL.PASSTHREE))	{
	_min=4;
	_max=5;
}


scr_dialoguemap_init(_min,_max);