//Created 18/07/19
//Last updated 18/07/19

//Checks if we're about to cross the room boundary
var spd=xspeed;
if argument_count>0
	{
		spd=argument[0];
	}
var roomedgecheck=sign(spd)*abs(bbox_left-bbox_right);
if bbox_left+roomedgecheck>room_width or bbox_right+roomedgecheck<0
	{
		return 1;
	}
return 0;