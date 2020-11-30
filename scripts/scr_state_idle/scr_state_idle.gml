//Created 05/10/19
//Last updated 05/10/19

//This is designed to be a flexible idle state using modules
var jumpinput=global.inputs[4];
var hinput=global.inputs[0];
var vinput=global.inputs[1];
var b_four=global.inputs[7];

if canmove=0
	{
		jumpinput=s_jump;
		hinput=s_hinput;
		vinput=s_vinput;
		b_four=s_b_four;
	}
if felloffcliff=1
	{
		hinput=0;
	}
	
if (slideoffcliffenabled==true)
	{
		var checkPosition=(global.gravdirection==90) ? bbox_bottom+1 : bbox_top-1;
		if (!instance_position(x,checkPosition,obj_solid) and !instance_position(x,checkPosition,obj_semisolid))
			{
				xspeed=0;
				state=PlayerState.slideoffcliff;
				//Make sure we're facing the correct direction
				//If you turn around you still slide a bit and can run over the cliff edge and fall off backwards
				//This causes problems
				//I.e. Sage teleports to (-1000,-1000) along with the enemy
				if (!position_meeting(bbox_left,checkPosition+1,obj_solid) and !position_meeting(bbox_left,checkPosition,obj_semisolid))
					{
						directionfacing=-1;
					}
				else
					{
						directionfacing=1;
					}
				exit;
			}
	}
	
//Now lets get some inputs, prioritise jumping, followed by running, followed by ducking and looking up
//Jumping - set the yspeed and set state to air
if (jumpinput=1 and jumpenabled)
	{
		scr_jump();
		exit;
	}

//First we'll check if we're in the air and exit the script if we are
//We also check if we're IN a semisolid
if (gravityenabled)
	if (scr_inaircheck())
		exit;

//Free flying for Sage and others maybe
if (freeflyingenabled)
	{
		var angle=arctan2(vinput,hinput);
		xspeed=sign(hinput)*abs(cos(angle))*acceleration;
		yspeed=sign(vinput)*abs(sin(angle))*acceleration;
		state=PlayerState.freeflying;
		exit;
	}

//This has to go above running or doesn't work
if (b_four and pullingenabled)
	{
		//There's a block to the right
		if (place_meeting(x+directionfacing,y,obj_solid))
			{
				state=PlayerState.pulling;
				exit;
			}
	}
	
if (b_four and dashenabled and candash and dashcooldown==0)
	{
		state=PlayerState.dashing;
		exit;
	}
	
if (b_four and gravityFlipEnabled)
	{
		state=PlayerState.GravityFlip;
		exit;
	}

//Running - set xspeed and set state to running (always linear)
if (hinput!=0 and runenabled)
	{
		scr_add_xacceleration_linear(hinput);
		directionfacing=hinput;
		state=PlayerState.running;
		exit;
	}
	
//ducking or looking up
//No exit because these might get overwritten by a cliff edge
if (vinput!=0)
	{
		//We need to flip this based on gravity
		var holdUpState=(global.gravdirection==90) ? PlayerState.lookup : PlayerState.duck;
		var holdDownState=(global.gravdirection==90) ? PlayerState.duck :  PlayerState.lookup;
		if (vinput>0 and lookupenabled)
			{
				state=holdUpState;
			}
		else if (duckenabled)
			{
				state=holdDownState;
			}
	}
	
//Cliff edges
//We check if there's no block under either the left or right bbox
if (cliffedgeenabled)
	{
		var cliffTolerence=abs(bbox_left-bbox_right)*0.25;	//How far do we have to move extra before a cliff is detected
		var cliffedge=false;
		var yCheck=(global.gravdirection==90) ? bbox_bottom+1 : bbox_top-1;
		if (!position_meeting(bbox_left+cliffTolerence, yCheck,obj_solid) and !position_meeting(bbox_left+cliffTolerence,yCheck,obj_semisolid))
			cliffedge=true;

		if (!position_meeting(bbox_right-cliffTolerence, yCheck,obj_solid) and !position_meeting(bbox_right-cliffTolerence,yCheck,obj_semisolid))
			cliffedge=true;
			
		//Fix for the edge of the screen being detected as a cliff
		if (bbox_left<=1 or bbox_right>=room_width-1)
			cliffedge=false;
			
		if (cliffedge)
			{
				state=PlayerState.cliffedge;
				exit;
			}
	}
	
//Waiting if in idle too long
//Becomes less likely to move to idle over time up to a cap of 1/1000
if (waitinganimationenabled)
	if (timeinstate>360 and irandom(120+max(880,timeinstate-360))==0)
		waiting=true;

//Waiting and foot tapping (pretty much Ed specific)
if (waiting and waitinganimationenabled)
	{
		if (sprite_index!=sprite_waiting)
			{
				sprite_index=sprite_waiting;
				image_index=0;
			}
			
		if (waitingtimeoutenabled)
			if image_index>image_number-0.5
				waiting=false;
						
		if (foottapenabled)
			{
				//Foot tap on 2,6,10,14,18,
				//Surely the most elegant way of doing this
				var ind=floor(image_index);
				if (ind==1 or ind==5 or ind==9 or ind==13 or ind==17)
					{
						if (!sound_on)
							{
								sound_on=true;
								scr_play_sound(sound_tap,false,0);
							}
					}
				else
					sound_on=false;
					
			if (image_index==clamp(image_index,7.5,8) and irandom_range(0,4)==0)
				image_index=0;
			}
		if (object_index==obj_eggbert_hatched)
			{
				var ind=floor(image_index);
				if (ind==4 or ind==8)
					{
						if (!sound_on)
							{
								sound_on=true;
								scr_play_sound(snd_platform_tick,false,0);
							}
					}
				else
					sound_on=false;
			}
	}

//Blinking
if (blinkingenabled and !waiting)
	{
		//Roll for a blink
		if (irandom_range(0,200)==0)
			blinking=15;
			
		blinking=max(0,blinking-1);
		
		if (blinking>0)
			sprite_index=sprite_blink;
		else
			sprite_index=sprite_idle;
	}

//Set the sprite if neither of the above are enabled
if (!blinking and !waiting)
	sprite_index=sprite_idle;
	
if (staticidleanimationenabled)
	image_speed=0;


//The sign lerps to a grid so it's still functional
if (isasignenabled and object_index!=obj_signman_mask)
	if (!place_meeting(x,y+1,obj_platform_signcontrolled))
		{
			//Lerp to grid
			var xgrid=round(x/16)*16;
			if (x==clamp(x,xgrid-1,xgrid+1))
				x=xgrid;
			else if (!place_meeting(xgrid,y,obj_solid))
				x=lerp(x,xgrid,0.1);
			else if (!place_meeting(xgrid+16,y,obj_solid))
				x=lerp(x,xgrid+16,0.1);
			else if (!place_meeting(xgrid-16,y,obj_solid))
				x=lerp(x,xgrid-16,0.1);
		}
			
//Digging
if (b_four and digenabled)
{
		state=PlayerState.digging;
		exit;
	}