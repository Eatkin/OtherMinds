//Created 05/10/19
//Last updated 05/10/19

var jumpinput=global.inputs[4];
var hinput=global.inputs[0];
var vinput=global.inputs[1];

if (!canmove)
	{
		jumpinput=s_jump;
		hinput=s_hinput;
		vinput=s_vinput;
	}
if (felloffcliff)
	hinput=0;
	
//Now lets get some inputs, prioritise jumping, followed by running, followed by ducking and looking up
//Jumping - set the yspeed and set state to air
if (jumpinput and jumpenabled)
	{
		scr_jump();
		/*yspeed=jumpheight;
		state=PlayerState.air;
		scr_play_sound(sound_jump,0,0);*/
		exit;
	}


//We can move to states air, duck, lookup or jump
//First we'll check if we're in the air and exit the script if we are
if (gravityenabled)
	if (scr_inaircheck())
		exit;

//Running - set xspeed and set state to running
if (hinput!=0)
	{
		xspeed=hinput*acceleration;
		state=PlayerState.running;
		exit;
	}


//New method:
var cliffedge=0;
//If there's no block underneath the bbox left
//Wait what the hell is the point of any of this?
//What was I thinking?
//Am I disabled?
//I think the second if statement is literally pointless

var gravMultiplier=dsin(global.gravdirection);
var yPosCheck=(gravMultiplier==1) ? bbox_bottom+1 : bbox_top-1;

//Orient which direction we're facing
if (!position_meeting(bbox_left,yPosCheck,obj_solid) and !position_meeting(bbox_left,yPosCheck,obj_semisolid))
	cliffedge=-1;
else if (!position_meeting(bbox_right,yPosCheck,obj_solid) and !position_meeting(bbox_right,yPosCheck,obj_semisolid))
	cliffedge=1;
	
if (cliffedge==0)
	{
	state=PlayerState.idle;
	exit;
	}
#region legacy code -there's possibly a reason there's this really stupid convoluted method of finding a cliff edge, but I'll ignore it unless I need to revert to it
/*
var inst=noone;
if (!instance_position(bbox_left,bbox_bottom+2,obj_solid) and !instance_position(bbox_left,bbox_bottom+2,obj_semisolid))
	{
		cliffedge=-1;
		var inst=instance_place(x,bbox_bottom+2,obj_solid)
		if inst=noone
			{
				inst=instance_place(x,bbox_bottom+2,obj_semisolid);
			}
	}
if (!instance_position(bbox_right,bbox_bottom+2,obj_solid) and !instance_position(bbox_right,bbox_bottom+2,obj_semisolid))
	{
		var inst=instance_place(x, bbox_bottom+2,obj_solid)
		if inst=noone
			{
				inst=instance_place(x,bbox_bottom+2,obj_semisolid);
			}
	}

//Failsafe - we'll revert to the previous method
if (inst==noone)
	{
		//Okay this checks no block under bbox_left but block under bbox_right
		if (!instance_position(bbox_left,bbox_bottom+2,obj_solid) and instance_position(bbox_right,bbox_bottom+2,obj_solid))
			{
				cliffedge=-1;
			}
		if (!instance_position(bbox_left,bbox_bottom+2,obj_semisolid) and instance_position(bbox_right,bbox_bottom+2,obj_semisolid))
			{
				cliffedge=-1;
			}
	}*/
/*else
	{
		//Get the centre of the sprite and compare that to the player's x pos
		var instx=inst.x+inst.sprite_width*0.5;
		if x<instx
			{
				cliffedge=-1;
			}
	}*/
#endregion
	
//Okay I think this is working but being messed up by something something image_xscale
//Anyway I'm going to fix it and then this comment will literally make no sense
//Why am I still typing this out
//I'll stop now
if (directionfacing==cliffedge)
	{
		sprite_index=sprite_cliff;
	}
else //Facing right on a left cliff edge
	{
		sprite_index=sprite_cliffbackwards;
	}