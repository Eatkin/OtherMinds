/// @description

if (place_meeting(x,y,parent_push))
	instance_destroy();
	
while (!place_meeting(x,y+8,obj_solid) and !place_meeting(x,y+8,obj_semisolid))	{
	y+=1;
	if (y>room_height)	{
		instance_destroy();
		break;
	}
}