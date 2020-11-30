/// @description Moves
// You can write your code in this editor

event_inherited();

if activated=0 or global.hardpause=1
	{
		scr_pause_alarms();
		exit;
	}

//So we'll have two stages of activation
//One for a short clip to show the platform coming down
//Anothre that doesn't do anything lol
if activated=1
	{
		/*REPLACE WITH APPROPRAITE EVENT
		global.edspaceevents_one=scr_event_set_complete(global.edspaceevents_one,EVENTS_EDSPACE_ONE.PLATFORMLOWERED);
		Actually set the event in the alarm
		*/
		//Make sure it can actually be on camera
		if (y>room_height)
			{
				y=room_height-1;
			}
		global.softpause=1;
		var objtofollow=id;
		with (obj_camera)
			{
				if following=noone
					{
						following=objtofollow;
					}
			}
		
		if scr_on_camera()=false and x>0
			{
				exit;
			}
		//lerp speed
		if y>room_height-64
			{
				yspeed=lerp(yspeed,ydirection*maxyspeed,0.05);
			}
		else
			{
				yspeed=lerp(yspeed,0,0.05);
			}
		//When stopped we go to activated 2
		if y<=room_height-64 and alarm[0]=-1
			{
				alarm[0]=30;
			}
		
		//Move an integer number of steps then a fractional movement to finish
		repeat(floor(abs(yspeed)))
			{
				y+=sign(yspeed);
			}
	}
	
if activated=2
	{
		//This doesn't do anything
	}