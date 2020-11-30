//Created 05/10/19
//Last updated 05/10/19

var hinput=global.inputs[0];
var b_four=global.inputs[19];

if (!canmove)
	{
		hinput=s_hinput;
		b_four=s_b_four;
	}
	
if (!b_four)
	{
		state=PlayerState.idle;
		exit;
	}
	
if (!place_meeting(x+directionfacing,y,parent_push) and !place_meeting(x+directionfacing,y,obj_solid))
	{
		state=PlayerState.idle;
		exit;
	}
	
//hinput is an on/off switch in this case
hinput=sign(hinput)*ceil(abs(hinput));
	
//Let's just add a break point for if we're in the air
if (gravityenabled)
	if (scr_inaircheck())
		exit;
	
if (hinput!=0)
	{
		//This means we're holding the opposite direction
		var objecttopull=instance_place(x+directionfacing,y,parent_push)
		//In this case we just need to check the player is free to move
		if (objecttopull!=noone)
			{
				repeat(pushspeed)
					{
						if (!place_meeting(x-directionfacing,y,obj_solid))
							{
								var collision=false;
								var _dir=directionfacing;
								with (objecttopull)	
									{
										collision=place_meeting(x-_dir,y,obj_solid)
									}
								if (collision)
									{
										break;
									}
								x-=directionfacing;
								objecttopull.x-=directionfacing;
							}
						else
							break;
					}
			}
	}

//We can only grab blocks in the direction we're facing, so hinput should be in the opposite to pull the block
//Therefore if our input is the same direction as the block we're trying to pull we move to push state
if (instance_place(x+sign(hinput),y,obj_solid)==instance_place(x+directionfacing,y,obj_solid) and pushingenabled)
	{
		state=PlayerState.pushing;
		exit;
	}
	
sprite_index=sprite_pull;
image_speed=abs(sign(hinput));