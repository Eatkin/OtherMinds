/// @description This needs to check if slime count increases
// You can write your code in this editor

if global.hardpause=1
	{
		scr_pause_alarms();
		exit;
	}

event_inherited();

var _list=ds_list_create();

//Check how many slimes are on it
var num=collision_line_list(x,y-1,x+sprite_width,y-1,parent_enemy,false,true,_list,false);

gloopcount=num;

ytarget=ystart+num*5;

var ydir=sign(ytarget-y);

if (y!=ytarget)	{
	y+=ydir;

	for (var i=0; i<num; i+=1)
		with (_list[| i])
			y+=ydir;
}
else
	gloopcountdraw=num;
		
		
//Now we will repeat the process, ensuring that no gloops have been trapped INSIDE the scales
ds_list_clear(_list);
var me=object_index;
num=collision_rectangle_list(x,y,x+sprite_width,y+sprite_height,parent_enemy,false,true,_list,false);
for (i=0; i<num; i+=1)
	with (_list[| i])
		while (place_meeting(x,y,me))
			y-=1;
	
ds_list_destroy(_list);

//Now check to activate - only if we haven't completed the level so the player doesn't get themselves stupidly stuck
if (!hasActivated and !scr_event_check_complete(global.edspaceevents_one,EVENTS_EDSPACE_ONE.COMPLETEDEDSPACETHREE) and gloopcountdraw==3)
	{
		hasActivated=true;
		global.softpause=true;
		var objtofollow=linkedinstance;
		with (obj_camera)
			if (following==noone)
				following=objtofollow;
	}
	
if (alarm[0]=-1 and obj_camera.following==linkedinstance)
	if scr_on_camera(linkedinstance)
		{
			alarm[0]=60;
			linkedinstance.activated=true;
			with (linkedinstance)
				scr_play_sound(snd_buttonpress,0,0);
		}