//Created 05/10/19

//By some error we can move into the push state in the air, probably some weird order of state movement or something

var gravMultiplier=dsin(global.gravdirection);

if (!place_meeting(x,y+gravMultiplier,obj_solid) and !place_meeting(x,y+gravMultiplier,obj_semisolid) and gravityenabled)
	{
		state=PlayerState.air;
		exit;
	}

var jumpinput=global.inputs[4];
var hinput=global.inputs[0];
var vinput=global.inputs[1];
var b_four=global.inputs[19];

if (!canmove)
	{
		jumpinput=s_jump;
		hinput=s_hinput;
		vinput=s_vinput;
		b_four=s_b_four;
	}

if (jumpinput and jumpenabled)
	{
		scr_jump();
		exit;
	}
	
//We need to check if we're holding pull and either neutral or holding the opposite direction
//Have to do this now because there's a break point below
if (b_four and sign(hinput)!=directionfacing and pullingenabled)
	{
		state=PlayerState.pulling;
		exit;
	}
	

if (hinput!=0)
	{
		if (!place_meeting(x+sign(hinput),y,obj_solid))
			{
				state=PlayerState.running;
				scr_add_xacceleration_linear(hinput);
				exit;
			}
	}
else
	{
		state=PlayerState.idle;
		exit;
	}

/*Okay for some reason this is completely screwy so I'm going to have to do the pushing from the pushable block's perspective
- but even that will cause problems because I've got to make sure every instance has a push state even if it's not used
How ridiculous*/
//Let's try again shall we
//We'll find the nearest pushable object
var _list=ds_list_create();
var _num=instance_place_list(x+directionfacing,y,parent_push,_list,false);
if (_num>0)
	{
		repeat (pushspeed)
			{
				for (var i=0; i<_num; i+=1)
					{
						var objecttopush=ds_list_find_value(_list,i);
				
						var collisioncheck=false;
						var _dir=directionfacing;
						with (objecttopush)
							collisioncheck=place_meeting(x+_dir,y,obj_solid);
						if (!collisioncheck)
								objecttopush.x+=directionfacing;
					}
				if (!place_meeting(x+directionfacing,y,obj_solid))
					x+=directionfacing;
			}
	}

	
ds_list_destroy(_list);
	
		
sprite_index=sprite_push;
image_speed=1;