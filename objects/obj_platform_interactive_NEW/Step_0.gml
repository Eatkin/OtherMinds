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
		global.softpause=1;
		var objtofollow=id;
		with (obj_camera)
			{
				if following=noone
					{
						following=objtofollow;
					}
			}
		if scr_on_camera()=false
			{
				exit;
			}
		//Ease speed down towards landing position
		//Slow down hard - should slow down in 28 pixels
		if y>=ymax
			{
				yspeed-=0.5;
			}
		else
			{
				yspeed+=0.1;
			}
		yspeed=clamp(yspeed,0,maxyspeed);
		//When stopped we go to activated 2 - i.e normal usage
		if yspeed=0
			{
				if alarm[0]=-1
					{
						alarm[0]=30;
						global.edspaceevents_one=scr_event_set_complete(global.edspaceevents_one,EVENTS_EDSPACE_ONE.PLATFORMLOWEREDNEW);
						scr_roomarray_set_secret_completed();
					}
			}
		
		//Move an integer number of steps then a fractional movement to finish
		repeat(floor(abs(yspeed)))
			{
				y+=sign(yspeed);
				yunperturbed=y;
			}
	}
	
//This is regular use as an elevator
//Holy shit what a godforsaken mess of code
if activated=2
	{
		var ontop=place_meeting(x,y-1,parent_possessable);
		var player=instance_place(x,y-1,parent_possessable);
		if player!=noone
			{
				if player.yspeed<0
					{
						player=noone;
						ontop=0;
					}
			}
		//Check if the player is on top when they weren't before so we can apply a perturbation
		if playerontop=0
			{
				if player!=noone
					{
						if player.y>y
							{
								ontop=0;
								player=noone;
							}
					}
				if ontop=1
					{
						playerontop=1;
						//Apply a perturbation
						if perturb=0
							{
								perturb=1;
								yunperturbed=y;
								perturbationdir=1;
							}
						else if perturbationdir=-1
							{
								perturbationdir=1;
							}
					}
			}
		else //Now we check if the player is not on top anymore
			{
				if ontop=0 or player=noone
					{
						playerontop=0;
					}
				if player!=noone
					{
						if player.y>y
							{
								playerontop=0;
								player=noone;
							}
					}
			}
		
		//Sets platform trajectory
		if playerontop=0
			{
				if yunperturbed>=ymax
					{
						yspeed-=0.5;
					}
				else
					{
						yspeed+=0.1;
					}
				yspeed=clamp(yspeed,0,maxyspeed);
			}
		else
			{
				if yunperturbed<=ymin
					{
						yspeed+=0.5;
					}
				else
					{
						yspeed-=0.1;
					}
				yspeed=clamp(yspeed,-maxyspeed,0);
			}
			
		//Movement
		repeat(floor(abs(yspeed)))
			{
				y+=sign(yspeed);
				yunperturbed+=sign(yspeed);
				if player!=noone
					{
						player.y+=sign(yspeed);
					}
			}
			
		//Add peturbation
		if perturb=1
		{
			var _y=y;
			if perturbationdir=1
				{
					y=lerp(y,yunperturbed+perturbamount,0.05);
					y=ceil(y);
					if y>=yunperturbed+perturbamount-0.2
						{
							y=yunperturbed+perturbamount;
							perturbationdir=-1;
						}
				}
			else
				{
					y=lerp(y,yunperturbed,0.05);
					y=floor(y);
					if y<yunperturbed+0.2
						{
							y=yunperturbed;
							perturb=0;
						}
				}
			//Update the carried objects y position
			var yperturbation=y-_y;
			if player!=noone
				{
					player.y+=yperturbation;
				}
		}
	}