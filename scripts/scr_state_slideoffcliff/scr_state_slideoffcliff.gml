//Created 06/10/19
//Last updated 06/10/19

var gravMultiplier=dsin(global.gravdirection);
//Emergency exit (glitch caused by when the on/off blocks turn off underneath them)
if (!place_meeting(x,y+gravMultiplier,obj_solid) and !place_meeting(x,y+gravMultiplier,obj_semisolid))
	{
		state=PlayerState.air;
		exit;
	}

//We must also lerp to a grid (this doesn't actually lerp, but I copied the code so whatever
var lerpdir=0;
if (!place_meeting(bbox_left,y+gravMultiplier,obj_solid) and !place_meeting(bbox_left,y+gravMultiplier,obj_semisolid))
	lerpdir=1;
if (!place_meeting(bbox_right,y+gravMultiplier,obj_solid) and !place_meeting(bbox_right,y+gravMultiplier,obj_semisolid))
	lerpdir=-1;
	
var bbox=(gravMultiplier==1) ? bbox_bottom+1 : bbox_top-1;
	
if (lerpdir!=0)
	while (!position_meeting(x+lerpdir,bbox,obj_solid) and !position_meeting(x+lerpdir,bbox,obj_semisolid))
		x+=lerpdir;

	
//Try and adjust the direction before its to late
if position_meeting(x-1,bbox,obj_solid) or position_meeting(x-1,bbox,obj_semisolid)
	directionfacing=1;
else
	directionfacing=-1;

//Extremely simple
//It just plays an animation then translates coordinates
if (sprite_index!=sprite_slideoffcliff)
	{
		sprite_index=sprite_slideoffcliff;
		image_index=0;
	}
if (image_index>image_number-1)
	{
		state=PlayerState.air;
		sprite_index=sprite_air;
		yspeed=1;
		xspeed=0;
		//Translate coordinates
		x+=8*directionfacing;
		y+=15*gravMultiplier;
	}
	
//This is an asymmetric sprite so change the offset
var yoff=sprite_get_yoffset(sprite_index);
var width=sprite_get_width(sprite_index);
if (directionfacing=-1)
	sprite_set_offset(sprite_index,width*0.5+1,yoff);
else
	sprite_set_offset(sprite_index,width*0.5,yoff);