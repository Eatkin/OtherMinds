/// @description States and stuff
// You can write your code in this editor

event_inherited();

//Augustus is largely the same except he cannot be killed and he talks to you and he doesn't attack you

//exit if paused -Although this is built in we have additional code so its necessary
if global.hardpause=1
	{
		image_speed=0;
		exit;
	}
image_speed=1;
	
scr_states_step();

if (abs(parent_main_character.x-x)<global.talkdistance)
	{
		timeinstate=0;
		waiting=false;
		directionfacing=scr_sign_nonzero(parent_main_character.x-x);
	}

//Awkward dialogue handling - here we complete the drink tea event, it should only complete once
if (dialogueprevious!=-1 and dialogueprevious!=4)
	{
		scr_todo_complete(1,localtodo);
		with (parent_main_character)
			{
				scr_todo_complete(9);
			}
	}

//The "sfx"
if (global.rng==2 and instance_exists(obj_darkness))
	{
		var reducedarkness=false;
		if (dialogueprevious==6 and textread[6]==false)
			{
				reducedarkness=true;
				textread[6]=true;
				with (obj_music)
					{
						fadingout=nowplaying;
						audio_sound_gain(fadingout,0,500);
						fadingoutsong=nowplayingsong;
						nowplaying=noone;
						nowplayingsong=-1;
					}
			}
		if (dialogueprevious==7 and textread[7]==false)
			{
				reducedarkness=true;
				textread[7]=true;
				var stat=instance_create_layer(x,y,layer,obj_static);
				stat.life=20;
				audio_play_sound(snd_sage_leave,0,false);
			}
		if (dialogueprevious==8 and textread[8]==false)
			{
				reducedarkness=true;
				textread[8]=true;
				var stat=instance_create_layer(x,y,layer,obj_static);
				stat.life=30;
				audio_play_sound(snd_sage_enter,0,false);
			}
		//darknessmultiplier, actually its multiplyer cause I made a typo
		if (reducedarkness=true)
			{
				with (obj_darkness)
					{
						darknessmultiplyer-=0.2;
					}
			}
	}
	
if (dialoguecomplete==true and instance_exists(obj_darkness))
	{
		with (obj_music)
			{
				if (nowplaying==noone)
					{
						var song=musicarray[MUSIC.SOUND_ID,6];
						nowplayingsong=song;
						nowplaying=audio_play_sound(song,0,false);
					}
			}
		//ONLY if we have finished a certain dialogue
		if (dialogueprevious==8)
			with (obj_darkness)
				darknessmultiplyer=lerp(darknessmultiplyer,1,0.1);

	}
//Outside room
if state=PlayerState.defeated
	{
		x=xstart;
		y=ystart;
		state=PlayerState.idle;
	}
	
//Augustine's behaviour
//He's really easy. Wake up and face the player is all that's necessary

if global.currentinstance=id
	{
		exit;
	}
	
//This is it, so simple
var player=instance_nearest(x,y,parent_main_character);
var xdist=abs(player.x-x);
if xdist<global.talkdistance+64 and distance_to_object(player)<global.talkdistance+128
	{
		//We do timeinstate=0 because we get stuttering when it tries to go to waiting
		timeinstate=0;
		waiting=0;
		directionfacing=scr_sign_nonzero(player.x-x);
	}