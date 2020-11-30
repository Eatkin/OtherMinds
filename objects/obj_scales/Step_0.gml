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

//Now if it detects a new slime we do a small oscillation
if gloopcount!=num
	{
		gloopcount=num;
		oscillationtimer=oscillationtimemax
		yoscillate=y;
		var _y=y;
		myemitter=instance_create_layer(x,y,layer,obj_sound_emitter);
		with (myemitter)
			{
				y=_y;
				scr_play_sound(snd_scales_land,0,0);
			}
	}

/*Oscillate and make sure to oscillation gloops with it
Sprite height is 9.
So we want f(x)=9*(sin(x)/x-1) except the steps are probably too big, so we'll do x=oscillationtimer/4
Actually we want f(x)=9*(sin(xoscillate+oscillationtimer)/xoscillate+oscillationtimer-1)
DO NOT EVALUATE AT X=0
Infact I'll make a script to make sure that doesn't happen
*/

if oscillationtimer>0
	{
		//Count up from 0
		var arg=(oscillationtimemax-oscillationtimer-8)*0.4;
		y=yoscillate+8*(scr_sinx_over_x(arg)-1);
		oscillationtimer-=1;
		if oscillationtimer=1
			{
				var _y=y;
				myemitter=instance_create_layer(x,y,layer,obj_sound_emitter);
				with (myemitter)
					{
						y=_y;
						scr_play_sound(snd_scales_move,0,0);
					}
			}
	}
	
if oscillationtimer=0 and y!=yoscillate+8
	{
		y=lerp(y,yoscillate+8,0.1);
		if abs(y-yoscillate-8)<0.5
			{
				y=yoscillate+8;
				gloopcountdraw=gloopcount;
				var _y=ystart-96;
				var _x=x+sprite_width*0.5-0.5*(sprite_get_width(spr_gloop_dotted)+sprite_get_width(spr_times)+16);
				myemitter=instance_create_layer(x,y,layer,obj_sound_emitter);
				with (myemitter)
					{
						y=_y;
						x=_x;
						scr_play_sound(snd_number_decrease,0,0);
					}
			}
	}
	
//Update x pos of emitter
if instance_exists(myemitter)
	{
		var player=global.currentinstance;
		var _x=player.x;
		if myemitter.y=ystart-96
			{
				var xmin=x+sprite_width*0.5-0.5*(sprite_get_width(spr_gloop_dotted)+sprite_get_width(spr_times)+16);
				var xmax=xmin+sprite_get_width(spr_screen);
				_x=clamp(_x,xmin,xmax);
			}
		else
			{
				_x=clamp(_x,x,x+sprite_width);
			}
		myemitter.x=_x;
	}
	
//Now update the x positionions of anything on top
//(If necessary)
if num=0
	{
		exit;
	}
	
var i;
var dy=y-yprevious;
for (i=0;i<num;i+=1)
	{
		with (_list[| i])
			{
				jumpenabled=false;
				canbehurtenabled=false;
				y+=dy;
			}
	}
	
ds_list_destroy(_list);

//Now check to activate - only if we haven't completed the level so the player doesn't get themselves stupidly stuck
if scr_event_check_complete(global.edspaceevents_one,EVENTS_EDSPACE_ONE.COMPLETEDEDSPACETHREE)=false and gloopcountdraw=3 and activated=0
	{
		activated=1;
		global.softpause=1;
		var objtofollow=linkedinstance;
		with (obj_camera)
			{
				if following=noone
					{
						following=objtofollow;
					}
			}
	}
	
if activated=1 and alarm[0]=-1
	{
		if scr_on_camera(linkedinstance)
			{
				alarm[0]=60;
				linkedinstance.activated=1;
				with (linkedinstance)
					{
						scr_play_sound(snd_buttonpress,0,0);
					}
			}
	}