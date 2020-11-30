//Created 07/10/19
//Last updated 07/10/19

//What the fuck is this

//Get variables
var hinput=global.inputs[0];
var vinput=global.inputs[1];

if (canmove==false)
	{
		hinput=s_hinput;
		vinput=s_vinput;
	}
	
//Normalise the input vectors if necessary
//We know sin^2(x)+cos^2(x)=1 always so this should only be applicable for keyboard input hopefully
//Actually I make sure I don't exceed max speed so that comment is totally meaningless and pointless now and I haven't deleted it for some reason
var normalise=sqrt(sqr(vinput)+sqr(hinput));
if (normalise)>1
	{
		vinput=vinput/normalise;
		hinput=hinput/normalise;
	}
var angle=arctan2(vinput,hinput);
var directionvector=arctan2(yspeed,xspeed);

/*This has ended up such a huge amount of fixes piled up on one another its just an ungodly mess
Send help*/
if hinput=0 and decelerationenabled=true
	{
		if abs(xspeed)>0
			{
				xspeed-=sign(xspeed)*acceleration*abs(cos(directionvector));
			}
	}
else
	{
		//This throttles the speed based on the position of the analog stick
		xspeed+=hinput*acceleration*abs(cos(angle));
		if abs(xspeed)*abs(cos(angle))>abs(hinput)*maxspeed*abs(cos(angle))
			{
				xspeed-=sign(hinput)*acceleration*abs(cos(angle));
			}
	}
if vinput=0 and decelerationenabled=true
	{
		if abs(yspeed)>0
			{
				yspeed-=sign(yspeed)*acceleration*abs(sin(directionvector));
			}
	}
else
	{
		//Same again, speed throttling
		yspeed+=vinput*abs(sin(angle))*acceleration
		if abs(yspeed)*abs(sin(angle))>abs(vinput)*maxspeed*abs(sin(angle))
			{
				yspeed-=sign(vinput)*acceleration*abs(sin(angle));
			}
	}


directionvector=arctan2(yspeed,xspeed);
//We should make sure we don't exceed max speeds and if we get arbitrarily slow we should stop
//There is a very minor rounding error that necessitates this stupid code
if abs(xspeed)<ceil(100*acceleration*abs(cos(directionvector)))/100
	{
		xspeed=0;
	}

if abs(yspeed)<ceil(100*acceleration*abs(sin(directionvector)))/100
	{
		yspeed=0;
	}

//Don't exceed max speed
//I'm trying to remove any ambiguity here
if abs(yspeed*sin(angle))>maxspeed*abs(sin(angle))
	{
		yspeed-=sign(yspeed)*acceleration;
	}
if abs(xspeed*cos(angle))>maxspeed*abs(cos(angle))
	{
		xspeed-=sign(xspeed)*acceleration;
	}
	
//Exit the script if we've stopped
if xspeed=0 and yspeed=0 and explodeonwallsenabled=false
	{
		state=PlayerState.idle;
		exit;
	}
	
//Okay that should be everything we need to move
var roomedgecheckh=sign(xspeed)*abs(bbox_left-bbox_right);
if abs(xspeed)<1
	{
		xmove=xspeed;
	}
else
	{
		xmove=sign(xspeed);
	}
repeat(ceil(abs(xspeed)))
	{
		if x+roomedgecheckh>room_width or x+roomedgecheckh<0
			{
				if explodeonwallsenabled=true
					{
						var emitter=instance_create_layer(x,y,"controllers",obj_sound_emitter);
						emitter.soundid=sound_explode;
						if global.currentinstance=id
							{
								scr_spawn_Sage();
							}
						instance_destroy();
						exit;
					}
				xspeed=0;
				break;
			}
		if !place_meeting(x+xmove,y,obj_solid)
			{
				x+=xmove;
			}
		else
			{
				if interactwithblocksenabled=false
					{
						if global.currentinstance=id
							{
								scr_spawn_Sage();
							}
						x+=xmove;
					}
				else
					{
						if explodeonwallsenabled=true
							{
								var emitter=instance_create_layer(x,y,"controllers",obj_sound_emitter);
								emitter.soundid=sound_explode;
								if global.currentinstance=id
									{
										scr_spawn_Sage();
									}
								instance_destroy();
								exit;
							}	
						xspeed=0;
						break;
					}
			}
	}
//O my brothers I do not know why I have to move in the opposite direction what the fuck
var roomedgecheckv=sign(yspeed)*abs(bbox_top-bbox_bottom);
if abs(yspeed)<1
	{
		ymove=yspeed;
	}
else
	{
		ymove=sign(yspeed);
	}
	
repeat(ceil(abs(yspeed)))
	{
		if y-roomedgecheckv>room_height or y-roomedgecheckv<0
			{
				yspeed=0;
				if explodeonwallsenabled=true
					{
						var emitter=instance_create_layer(x,y,"controllers",obj_sound_emitter);
						emitter.soundid=sound_explode;
						if global.currentinstance=id
							{
								scr_spawn_Sage();
							}
						instance_destroy();
						exit;
					}
				break;
			}
		if !place_meeting(x,y-ymove,obj_solid)
			{
				y-=ymove;
			}
		else
			{
				if interactwithblocksenabled=false
					{
						if global.currentinstance=id
							{
								scr_spawn_Sage();
							}
						y-=ymove;
					}
				else
					{
						if explodeonwallsenabled=true
							{
								var emitter=instance_create_layer(x,y,"controllers",obj_sound_emitter);
								emitter.soundid=sound_explode;
								if global.currentinstance=id
									{
										scr_spawn_Sage();
									}
								instance_destroy();
								exit;
							}
						yspeed=0;
						break;
					}
				yspeed=0;
				break;
			}
	}
	
//Okay lets also just set yspeed to 0 in this case
//This SHOULD only happen when you've hit a barrier because of weird stupid dumb idiot collission
//Because i'm a weird stupid dumb idiot
if y=yprevious
	{
		yspeed=0;
	}
	
sprite_index=sprite_freeflying;