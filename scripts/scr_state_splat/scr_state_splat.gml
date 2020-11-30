//Created 06/10/19
//Last updated 06/10/19

var gravMultiplier=dsin(global.gravdirection);

//Wwe need to move into contact with solids or semisolid, for some reason we don't dunno why
var hasRepeated=false;
repeat(2)
	{
		if (!place_meeting(x,y+gravMultiplier,obj_solid) and !place_meeting(x,y+gravMultiplier,obj_semisolid))
			if (!hasRepeated)
				y+=gravMultiplier;
			else
				{
					state=PlayerState.air;
					exit;
				}
			
		hasRepeated=true;
	}

//Just plays animation then returns control
if (image_index>image_number-0.5)
	state=PlayerState.idle;


if (timeinstate==0)
	{
		var particleNum=irandom(10);
		repeat (particleNum)
			{
				var xx=choose(bbox_left,bbox_right);
				var yy=bbox_bottom;
				var minangle=(xx==bbox_left) ? 30 : 120;
				var maxangle=(xx==bbox_right) ? 60: 150;
				part_type_direction(global.gloopParticle,minangle,maxangle,0,0);
				part_particles_create_colour(global.partSys,xx,yy,global.gloopParticle,splatColour,1);
			}
	}

//We must also lerp to a grid
//This is SUPER BROKEN
var lerpdir=0;
var bboxCheck=(gravMultiplier==1) ? bbox_bottom+1 : bbox_top-1;
if (!position_meeting(bbox_left,bboxCheck,obj_solid) and !position_meeting(bbox_left,bboxCheck,obj_semisolid))
	lerpdir=1;
if (!position_meeting(bbox_right,bboxCheck,obj_solid) and !position_meeting(bbox_right,bboxCheck,obj_semisolid))
	lerpdir=-1;
var grid=64;
//No this is not overly complicated
if (lerpdir!=0)
	{
		var xtarget;
		if (lerpdir==1)
			xtarget=ceil(x/grid)*grid;
		else
			xtarget=(floor(x/grid)-1)*grid;
		x=lerp(x,xtarget,0.1);
	}