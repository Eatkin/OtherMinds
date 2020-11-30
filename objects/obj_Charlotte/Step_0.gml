/// @description Step code for movement etc
// You can write your code in this editor

event_inherited();

if global.hardpause=1
	{
		image_speed=0;
		exit;
	}
image_speed=1;

scr_states_step();
	
//Need some idle behaviour here - if we're in the living room, we walk back and forth
if (room==rm_Edlivingroom and global.currentinstance!=id)
	{
		if (walking==false)
			{
				if (irandom(180)==0 and ds_queue_empty(global.dialoguequeue))
					{
						walking=true;
						if (irandom(5)==0)
							{
								directionfacing*=-1;
							}
						if (place_meeting(x+directionfacing*8,y,obj_solid))
							{
								directionfacing*=-1;
							}
					}
			}
		else
			{
				s_hinput=directionfacing;
				if (irandom(180)==0)
					{
						walking=false;
					}
				if (place_meeting(x+directionfacing*8,y,obj_solid))
					{
						walking=false;
					}
			}
	}