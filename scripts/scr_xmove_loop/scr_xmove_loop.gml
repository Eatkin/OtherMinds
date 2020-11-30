//Created 16/07/19
//Last updated 31/07/19

//Repeat loop for moving in the x direction
var hinput=argument0; //This is literally never used why did I include it?
var speedoperator;

var gravMultiplier=(global.gravdirection==90) ?	1	:	-1;


if (abs(xspeed)<0)
	speedoperator=xspeed;
else
	speedoperator=sign(xspeed);
	
repeat(ceil(abs(xspeed)))
	{
		//This is an annoying condition I have to include for some reason
		if (scr_room_edge_check())
			{
				if (hinput==0 or state==PlayerState.dashing)
					xspeed=0;
				break;
			}
		if (!place_meeting(x+sign(speedoperator),y,obj_solid) or !interactwithblocksenabled)
			x+=speedoperator;
		else
			{
				if (state==PlayerState.air)
					{
						var yrepeat=ceil(abs(yspeed));
						var ydir=sign(yspeed);
						var movedthroughgap=false;
						for (var i=0; i<yrepeat; i+=1)
							{
								if (!place_meeting(x+speedoperator,y-ydir*i,obj_solid))
									{
										y=y-ydir*i;
										yspeed=0;
										x+=speedoperator;
										movedthroughgap=true;
										break;
									}
							}
						if (movedthroughgap==false)
							{
								xspeed=0;
							}
					}
				else
					{
						//Go up blocks if they're just a short step
						if (maxxspeed>=4 and !place_meeting(x+speedoperator,y-16*gravMultiplier,obj_solid) and !place_meeting(x+speedoperator,y,parent_push))
							{
								x+=speedoperator
								y-=16*gravMultiplier;
							}
						else
							xspeed=0
					}
				break;
			}
	}