//No floor underneat us
var yCheck=y+dsin(global.gravdirection);
if (!place_meeting(x,yCheck,obj_solid) and !place_meeting(x,yCheck,obj_semisolid))
	{
		state=PlayerState.air;
		return true;
	}
//Are we IN a semisolid?
if (place_meeting(x,y,obj_semisolid) and !place_meeting(x,yCheck,obj_solid))
	{
		//First let's check if we're actually on a semi solid as well as in one
		var semiSCheck=(global.gravdirection==90) ? bbox_bottom : bbox_top;
		var semi_s1=instance_position(x,semiSCheck+dsin(global.gravdirection),obj_semisolid);
		var semi_s2=instance_position(x,semiSCheck,obj_semisolid);
		if (semi_s1==semi_s2 or semi_s1==noone)
			{
				state=PlayerState.air;
				return true;
			}
	}
	
return false;