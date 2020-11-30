//Created 09/11/19
//Last updated 09/11/19

/*
Add momentum upwards until we hit wallclimbspeed
then we just dp a movement loop
if we hit a ledge hold point, convert to that state
We also need to do wall jumping as with on wall state
*/
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

//Exit conditions
if sign(vinput)!=1 and yspeed>=0
	{
		state=PlayerState.onwall;
		exit;
	}
if !place_meeting(x+directionfacing,y,obj_solid)
	{
		state=PlayerState.air;
		exit;
	}
	
//Wall direction and whatever
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

//Now climbing
if sign(vinput)=1
	{
		onwalltimer=0;
		yspeed-=1;
		if yspeed<0
			{
				yspeed=clamp(yspeed,-wallclimbspeed,0);
			}
	}
//Slow down
if sign(vinput)=0 and yspeed<0
	{
		yspeed+=1;
		if yspeed=clamp(yspeed,-global.gravstrength,global.gravstrength)
			{
				yspeed=0;
			}
		if yspeed=0
			{
				state=PlayerState.onwall;
				exit;
			}
	}
	
//Jump control
if jumpinput=true
	{
		var angle=45;
		if holdingawayfromwall=true
			{
				angle=30;
			}
		var height=jumpheight;
		
		var _xjump=height*dcos(angle)*walldirection;
		var _yjump=height*dsin(angle);
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

//Now a movement loop
repeat(ceil(abs(yspeed)))
	{
		if !place_meeting(x,y+sign(yspeed),obj_solid)
			{
				//We break if we meeting a cliff top
				if yspeed<0
					{
						if !position_meeting(x+image_xscale*sprite_width*0.5*walldirection,bbox_top-1,obj_solid)
							{
								if ledgeclimbenabled=false
									{
										state=PlayerState.ledgegrab;
										exit;
									}
								else
									{
										//This checks the coordinates at which you will be after climbing the ledge for collision checking
										//Change mask for collision checks
										mask_index=masknormal;
										var xtemp=x+ledgextranslation*directionfacing;
										var ytemp=y-ledgeytranslation;
										if !place_meeting(xtemp,ytemp,obj_solid)
											{
												state=PlayerState.ledgeclimb;
											}
										else
											{
												state=PlayerState.ledgegrab;
											}
										if airmaskenabled=true
											{
												mask_index=maskair;
											}
										exit;
									}
							}
					}
				y+=sign(yspeed);
			}
		else
			{
				yspeed=0;
				state=PlayerState.onwall;
				exit;
			}
	}
	
//We break if we meeting a cliff top (again)
if yspeed<0 and !place_meeting(x,y-1,obj_solid)
	{
		if !position_meeting(x+image_xscale*sprite_width*0.5*walldirection,bbox_top-1,obj_solid)
			{
				if ledgeclimbenabled=false
					{
						state=PlayerState.ledgegrab;
						exit;
					}
				else
					{
						//This checks the coordinates at which you will be after climbing the ledge for collision checking
						//Change mask for collision checks
						mask_index=masknormal;
						var xtemp=x+ledgextranslation*directionfacing;
						var ytemp=y-ledgeytranslation;
						if !place_meeting(xtemp,ytemp,obj_solid)
							{
								state=PlayerState.ledgeclimb;
							}
						else
							{
								state=PlayerState.ledgegrab;
							}
						if airmaskenabled=true
							{
								mask_index=maskair;
							}
						exit;
					}
			}
	}
	
//Sprite selection
directionfacing=walldirection;
sprite_index=sprite_wallclimb;
image_speed=1;


var playsound=false;
if object_index=obj_Mig or object_index=obj_Frankie
	{
		var imgindex=(image_index+1)%4;
		if imgindex=clamp(imgindex,0,0.25)
			{
				playsound=true;
			}
	}
	
if playsound=true
	{
		scr_play_sound(sound_wallclimb,0,0);
	}