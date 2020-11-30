//Created 19/08/19
//Last updated 19/08/19

//This snaps the object to the floor if the floor is below then updates starting position
var dir=(global.gravdirection==90)	?	1	:	-1;
if (place_meeting(x,y+32*dir,obj_solid))
		{
			var repeats=0;
			while (!place_meeting(x,y+dir,obj_solid))
				{
					y+=dir;
					repeats+=1;
					if (repeats>32)
						break;
				}
		}
	
	
//Don't do this its bound to fuck somethig up in future
//ystart=y;