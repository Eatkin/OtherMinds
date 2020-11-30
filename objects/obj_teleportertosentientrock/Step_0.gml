/// @description Can Teleport switch
// You can write your code in this editor

if (place_meeting(x,y,parent_possessable) && canteleport==true)
	{
		var player=instance_place(x,y,parent_possessable);
		if (player.state=PlayerState.running or player.state=PlayerState.idle) and global.currentinstance=player and player.teleportenabled=true
			{
				theplayer=player;
				scr_teleport_map_set_activated();
				player.state=PlayerState.teleport;
				player.xspeed=0;
				player.yspeed=0;
				canteleport=canteleport^1;
			}
	}
if (!place_meeting(x,y,parent_possessable))
	{
		canteleport=true;
	}
	
//So what we want to do now is say if theplayer!=noone we check if they've finished their teleport
//If they have make invisible, gainoverride=0, spawn a level transition obj
if (theplayer!=noone)
	{
		var finishedport=false;
		var _x=0;
		var _y=0;
		with (theplayer)
			{
				if (sprite_index==sprite_teleport_backwards)
					{
						gainoverride=0;
						visible=false;
						_x=x;
						_y=y;
						finishedport=true;
					}
			}
		if (thetransition==noone and finishedport==true)
			{
				thetransition=instance_create_layer(_x,_y,layer,obj_dooractivateontouch)
				thetransition.destination=rm_ochrehill_bonus;
				thetransition.visible=false;
				global.globalevents=scr_event_set_complete(global.globalevents,EVENTS_GLOBAL.ROCKTELEPORTACTIVE);
			}
	}