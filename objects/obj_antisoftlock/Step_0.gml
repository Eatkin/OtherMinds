/// @description


if global.hardpause=true
	{
		scr_pause_alarms();
		exit;
	}
var player=global.currentinstance;
if !place_meeting(x,y,parent_main_character) or object_get_parent(player.object_index)!=parent_main_character
	{
		exit;
	}

if player.state=PlayerState.dead
	{
		alarm[0]=-2;
		exit;
	}
//We check 32 points, if we find a block above all of them, we trigger the anti softlock, else we set the alarm so it won't be triggered
var count=0
for (var i=0; i<32; i+=1)
	{
		if !position_meeting(x+i,y-1,obj_solid)
			{
				count+=1;
			}
	}
	
var width=player.bbox_right-player.bbox_left;
if count>width
	{
		exit;
	}
	
if alarm[0]=-2
	{
		alarm[0]=60;
	}