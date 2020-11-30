/// @description
// Inherit the parent event
event_inherited();

instance_create_layer(x+sprite_width*0.5,y,"Players",obj_smoke);

var vibamount;
var dist=distance_to_object(global.currentinstance);
var maxdist=256;
vibamount=1-min(1,dist/maxdist);
scr_set_vibration(vibamount,vibamount,10);

var x1=x-sprite_width*2;
var x2=x+sprite_width*2;
var y1=y-sprite_height*2;
var y2=y+sprite_height*2;
with (obj_crackedblock)
	{
		var _x=x+sprite_width*0.5;
		var _y=y+sprite_height*0.5;
		if _x=clamp(_x,x1,x2) and _y=clamp(_y,y1,y2)
			{
				instance_destroy();
			}
	}

with (obj_justinwall)
	{
		if (scr_event_check_complete(global.ochre_events,OCHRE_EVENTS.JUSTIN_WALLED)==true)
			{
				break;
			}
		var _x=bbox_left;
		if (_x==clamp(_x,x1,x2) and y==clamp(y,y1,y2))
			{
				state=PlayerState.wallfall;
			}
	}