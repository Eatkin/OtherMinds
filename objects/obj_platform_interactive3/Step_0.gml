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
//Then one for regular use
if activated=1
	{
		/*REPLACE WITH APPROPRAITE EVENT
		global.edspaceevents_one=scr_event_set_complete(global.edspaceevents_one,EVENTS_EDSPACE_ONE.PLATFORMLOWERED);
		*/
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
		if x<xstart+96
			{
				xspeed=lerp(xspeed,xdirection*maxxspeed,0.05);
			}
		else
			{
				xspeed=lerp(xspeed,0,0.25);
			}
		//When stopped we go to activated 2
		if x>=xstart+96 and alarm[0]==-1
			{
				alarm[0]=30;
			}
		
		//Move an integer number of steps then a fractional movement to finish
		repeat(floor(abs(xspeed)))
			{
				x+=sign(xspeed);
			}
	}
	
if activated=2
	{
		//This doesn't do anything
	}