/// @description Can Teleport switch
// You can write your code in this editor

var gravMultiplier=(global.gravdirection==90)	?	1	:	-1;

if (gravMultiplier==-1)
	exit;

if place_meeting(x,y,parent_possessable) && canteleport=1
	{
		var player=instance_place(x,y,parent_possessable);
		if (player.state=PlayerState.running or player.state=PlayerState.idle) and global.currentinstance=player and player.teleportenabled=true
			{
				scr_teleport_map_set_activated();
				player.state=PlayerState.teleport;
				player.xspeed=0;
				player.yspeed=0;
				canteleport=canteleport^1;
			}
	}
if !place_meeting(x,y,parent_possessable)
	{
		canteleport=1;
	}