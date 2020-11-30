/// @description Movement and bouncing
// You can write your code in this editor

//collide with a main character
//This must go above the inherited event or its doesn't work
if (tangible and place_meeting(x,y,parent_main_character))
	global.edSpaceTwoEvents=scr_event_set_complete(global.edSpaceTwoEvents,EdSpaceTwoEvents.COLLECTEDYELLOWKEY);

if (tangible)
	event_inherited();

if (global.hardpause)
	exit;

var gravMultiplier=(global.gravdirection==90)	?	1	:	-1;

//Xspeed with bounce against walls
var playsound=0;
repeat(ceil(abs(xspeed)))
	{
		//Room boundary
		if x+sign(xspeed)<0 or x+sign(xspeed)>=room_width
			{
				xspeed=-xspeed*restitution;
				playsound=1;
				x+=sign(xspeed);
				if abs(xspeed)<1
					{
						xspeed=0;
					}
			}
		else if !place_meeting(x+sign(xspeed),y,obj_solid)
			{
				x+=sign(xspeed);
			}
		else
			{
				xspeed=-xspeed*restitution;
				playsound=1;
				x+=sign(xspeed);
				if abs(xspeed)<1
					{
						xspeed=0;
					}
			}
	}
	
//Yspeed with bounce against floors
repeat (ceil(abs(yspeed)))
	{
		if (!place_meeting(x,y+sign(yspeed),obj_solid))
			{
				y+=sign(yspeed);
			}
		else
			{
				//Update safe coords when hitting the floor
				playsound=1;
				xsafe=x;
				ysafe=y;
				yspeed=-yspeed*restitution;
				//y+=sign(yspeed);
				if abs(yspeed)<1
					{
						xspeed=0;
						yspeed=0;
						exit;
					}
			}
	}

if (playsound)
	scr_play_sound(snd_item_bounce,false,0);
	
yspeed+=global.gravstrength*gravMultiplier;