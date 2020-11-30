//Created 09/11/19
//Last updated 09/11/19

xspeed=0;

var jumpinput=global.inputs[4];
var hinput=global.inputs[0];
var vinput=global.inputs[1];

if canmove=0
	{
		jumpinput=s_jump;
		hinput=s_hinput;
		vinput=s_vinput;
	}

var holdingagainstwall=false;
var holdingawayfromwall=false;
var walldirection=directionfacing;

if place_meeting(x+1,y,obj_solid)
	{
		walldirection=1;
	}
else if place_meeting(x-1,y,obj_solid)
	{
		walldirection=-1;
	}

//Exit condition
if !place_meeting(x+directionfacing,y,obj_solid)
	{
		state=PlayerState.air;
		exit;
	}
	

//Determine whether we're holding against a wall or away from etc
if sign(hinput)=walldirection
	{
		holdingagainstwall=true;
		onwalltimer=0;
		wallholdawaytimer=0;
	}
else if sign(hinput)=-walldirection
	{
		holdingawayfromwall=true;
		wallholdawaytimer+=1;
	}
else
	{
		wallholdawaytimer=0;
		onwalltimer+=1;
	}

//Control the yspeeds - slow down if we're holding against the wall
if holdingagainstwall=true and yspeed!=0
	{
		yspeed-=global.gravstrength*0.5;
		if abs(yspeed)<global.gravstrength
			{
				yspeed=0;
			}
	}
//Speed up if we're not holding against the wall
if onwalltimer>30
	{
		yspeed+=0.5*global.gravstrength;
	}

//Now move out of this state if we've held away from wall for too long
if wallholdawaytimer>30
	{
		state=PlayerState.air;
		exit;
	}
	
//Now move into wallclimb state if we can
if wallclimbenabled=true
	{
		if vinput>0
			{
				onwalltimer=0
				if !place_meeting(x,y-1,obj_solid)
					{
						state=PlayerState.wallclimb;
					}
				exit;
			}
	}
	
//Now we can jump
if jumpinput=true
	{
		var angle=45;
		if holdingawayfromwall=true
			{
				angle=30;
			}
		var height=jumpheight;
		
		var _xjump=height*dcos(angle)*walldirection;
		var _yjump=height//*dsin(angle);	//Don't component-wise the y direction because it gives a crap jump
		xspeed+=_xjump;
		x+=sign(_xjump);
		directionfacing=sign(_xjump);
		xspeed=clamp(abs(xspeed),0,maxxspeed)*sign(xspeed);
		yspeed+=_yjump;
		state=PlayerState.air;
		scr_play_sound(sound_jump,0,0);
		exit;
	}

//Clamp the yspeed
yspeed=clamp(yspeed,-maxyspeed,maxyspeed);

//Movement loop
//Now a movement loop
repeat(ceil(abs(yspeed)))
	{
		//We break if we meeting a cliff top
		if yspeed<0
			{
				if !position_meeting(x+image_xscale*sprite_width*0.5*walldirection,bbox_top-1,obj_solid)
					{
						state=PlayerState.ledgegrab;
						exit;
					}
			}
		if !place_meeting(x,y+sign(yspeed),obj_solid)
			{
				y+=sign(yspeed);
			}
		else
			{
				break;
			}
	}
if place_meeting(x,y+1,obj_solid)
	{
		state=PlayerState.idle;
	}
	
//Sprite selection
directionfacing=walldirection;
sprite_index=sprite_onwall;
image_speed=1;