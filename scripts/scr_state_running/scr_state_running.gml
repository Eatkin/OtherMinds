//Created 05/10/19
//Last updated 05/10/19

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

//This is just moving left and right generally
//We can break out by either stopping, pushing against a wall or jumping

//While on the ground we need to set our coyote timer
coyotetime=coyotetimemax;

//Jumping FIRST
if (jumpinput and jumpenabled)
	{
		scr_jump();
		exit;
	}

//If we receive hinput and we're below max speed
//add acceleration
if (hinput!=0)
	if (smoothaccelerationenabled)
		scr_add_xacceleration_smooth(hinput);
	else
		scr_add_xacceleration_linear(hinput);
else if (decelerationenabled)
	if (smoothaccelerationenabled)
		scr_subtract_xacceleration_smooth();
	else
		scr_subtract_xacceleration_linear();

	
var yCheck=(global.gravdirection==90) ? bbox_bottom+1 : bbox_top-1;
if (slideoffcliffenabled)
	if !instance_position(x,yCheck,obj_solid) and !instance_position(x,yCheck,obj_semisolid)
		{
			xspeed=0;
			state=PlayerState.slideoffcliff;
			exit;
		}

//Move loop
scr_xmove_loop(hinput);

var imgspeed=-1; //It looks weird for instances that don't push so we animate them
//Now determine whether to move to idle state or pushing state
if (xspeed==0)
	{
		if (hinput==0)
			{
				state=PlayerState.idle;
				exit;
			}
		if (pushingenabled)
			if (place_meeting(x+sign(hinput),y,obj_solid))
				{
					state=PlayerState.pushing;
					exit;
				}
		else
			imgspeed=1;
			
		//A really weird specific case for when hitting a room edge apaprently?
		if (hinput!=0 and !place_meeting(x+sign(hinput),y,obj_solid))
			{
				state=PlayerState.idle;
				exit;
			}
	}
	
//Oh and also I forgot to actually fall if in the air
if (gravityenabled)
	if (scr_inaircheck())
		exit;

//Dash
if (b_four and dashenabled and candash and dashcooldown==0)
	{
		state=PlayerState.dashing;
		exit;
	}

	
//Sprite selection
sprite_index=sprite_run;
if (imgspeed=-1)
	image_speed=min(abs(xspeed)*1/abs(hinput)*maxxspeed,1);
else
	image_speed=1;
	
if (imagespeedequalsdirenabled)
	image_speed*=directionfacing;

//Also create dust at max speed
if (dustenabled)
	{
		if (abs(xspeed)>=maxxspeed and dustcounter==0)
			{
				//Decide spawn point based on direction
				var xdust=bbox_left;
				if (directionfacing==-1)
					xdust=bbox_right;
				if (!xscaleflipenabled and x<xprevious)
					xdust=bbox_right;
					
				var dusty=(global.gravdirection==90) ? bbox_bottom : bbox_top;
				var dust=instance_create_layer(xdust,dusty,layer,obj_dust_trail);
				dust.depth-=1;
				dust.image_yscale=(global.gravdirection==90) ? 1 : -1;
				dustcounter=15;
			}
		dustcounter=max(0,dustcounter-1);
	}
	
//Digging
if (b_four and digenabled)
	{
		state=PlayerState.digging;
		exit;
	}