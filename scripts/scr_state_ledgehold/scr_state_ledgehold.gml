//Created 05/10/19
//Last updated 05/10/19

var jumpinput=global.inputs[4];
var hinput=global.inputs[0];
var vinput=global.inputs[1];
var b_four=global.inputs[7];

var xtemp;

var gravMultiplier=dsin(global.gravdirection);
if (directionfacing==1)
	xtemp=bbox_right+directionfacing;
else
	xtemp=bbox_left+directionfacing;
	
//This checks we're still holding a ledge - accounts for moving platforms etc
var bboxCheck=(gravMultiplier==1) ? bbox_top : bbox_bottom;
if (!instance_position(xtemp,bboxCheck,obj_solid) or instance_position(xtemp,bboxCheck-gravMultiplier,obj_solid) or place_meeting(x,bboxCheck+gravMultiplier,obj_solid))
	{
		state=PlayerState.idle;
		exit;
	}
//You can have a toggle block appear above you which means you should let go of the ledge
if (place_meeting(x,y-gravMultiplier,obj_solid))
	{
		state=PlayerState.idle;
		exit;
	}

if (!canmove)
	{
		jumpinput=s_jump;
		hinput=s_hinput;
		vinput=s_vinput;
		b_four=s_b_four;
	}

//Stop hspeed because otherwise its conserved and you shoot forward
if (xspeed!=0)
	xspeed=0;
	
//Drop off the ledge
if (sign(vinput)=-gravMultiplier)
	{
		state=PlayerState.air;
		yspeed=gravMultiplier;
		y+=gravMultiplier;
		exit;
	}

//Jump up
if (jumpinput and jumpenabled)
	{
		//Give a little boost for jumping away from the wall
		if (sign(hinput)=-directionfacing and ledgeholdawayenabled)
			xspeed=jumpheight*directionfacing*(1/sqrt(2));
			
		yspeed=jumpheight*gravMultiplier;
		state=PlayerState.air;
		y-=gravMultiplier;
		scr_play_sound(sound_jump,0,0);
		exit;
	}


//Okay this checks if we're holding the hinput away from the ledge
var facingledge=true;
if (sign(hinput)=-directionfacing and ledgeholdawayenabled)
	facingledge=false;

	
//Extremely confusing sprite selection
//Which doesn't work very well
//So I'm writing it again
//Maybe it won't be extremely confusing this time
//Okay we basically need to switch between sprites
/*We check if we're on the hold away animation
if we are, but not holding away
then reverse the animation
if we're at the end (beginning) of the animation it switches back
then basically the same
sdid that even make any sense?
I don't know
i'm never going to read this again*/
if (ledgeholdawayenabled)
	{
		if (facingledge)
			{
				if (sprite_index!=sprite_ledgeholdaway)
					{
						sprite_index=sprite_ledgehold;
						image_speed=1;
					}
				else
					{
						image_speed=-1;
						if (image_index<0.5)
							{
								image_index=0;
								sprite_index=sprite_ledgehold;
							}
					}
			}
		else
			{
				if (sprite_index!=sprite_ledgeholdaway)
					{
						sprite_index=sprite_ledgeholdaway;
						image_index=0;
					}
				if (image_index>image_number-1)
					image_speed=0;
				else
					image_speed=1;
			}
	}
else
	{
		sprite_index=sprite_ledgehold;
		image_speed=1;
	}
	
//Now we've done all that then we can do ledge climbing
if (sign(vinput)=gravMultiplier and sprite_index=sprite_ledgehold and ledgeclimbenabled)
	{
		//This checks the coordinates at which you will be after climbing the ledge for collision checking
		//Change mask for collision checks
		mask_index=masknormal;
		var xtemp=x+ledgextranslation*directionfacing;
		var ytemp=y-ledgeytranslation*gravMultiplier;
		if (!place_meeting(xtemp,ytemp,obj_solid))
			state=PlayerState.ledgeclimb;
		if (airmaskenabled)
			mask_index=maskair;
	}