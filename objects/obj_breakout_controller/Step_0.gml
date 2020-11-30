/// @description

//When activated fix camera to x=344, y=152
//We need to detect when ball goes too low
//Need to 

var player=parent_main_character;

if (activated==false and player.x>592)
	{
		activated=true;
		var xlock=344;
		var ylock=160;
		scr_regionlock(xlock,ylock,false);
		ballspawning=true;
		ballspawntimer=ballspawntimermax;
		with (obj_breakout_paddle)
			{
				activated=true;
			}
	}
	
if (activated==true)
	{
		if (ballspawning==true and ballspawntimer==ballspawntimermax)
			{
				var paddle=obj_breakout_paddle;
				myballs=instance_create_layer(paddle.x+paddle.sprite_width*0.5,paddle.y-16,layer,obj_breakout_ball);
				ballspawning=false;
			}
		if (myballs!=noone)
			{
				if (ballspawntimer%10==0 and ballspawntimer>0)
					{
						myballs.whitesprite=myballs.whitesprite^1;
					}
				if (ballspawntimer==0)
					{
						myballs.whitesprite=false;
						myballs._speed=1.5;
						myballs.activated=true;
					}
				if (ballspawntimer>0)
					{
						myballs.x=obj_breakout_paddle.x+obj_breakout_paddle.sprite_width*0.5;
					}
					
				//Now lets check its not below the paddle
				var paddle=obj_breakout_paddle;
				if (myballs.bbox_top>paddle.bbox_bottom)
					{
						instance_destroy(myballs);
						myballs=noone;
						spikestimer=spikestimermax;
					}
				ballspawntimer-=1;
			}
		if (spikestimer>0)
			{
				if (spikes==false)
					{
						with (parent_main_character)
							{
								scr_set_vibration(1,1,10);
								scr_play_sound(snd_spikes_eject,false,false);
								scr_camera_screenshake_y(7);
							}
						spikes=true;
						for (var i=0;i<29;i+=1)
							{
								instance_create_layer(352+16*i,384,layer,obj_ochrespikes);
							}
					}
			}
		else
			{
				var player=parent_main_character;
				if (spikes==true and player.state!=PlayerState.defeated and player.state!=PlayerState.dead)
					{
						with (obj_ochrespikes)
							{
								instance_destroy();
							}
						spikes=false;
						ballspawning=true;
						ballspawntimer=ballspawntimermax;
					}
			}
		spikestimer-=1;
		
		if (instance_number(obj_breakout_block)==0)
			{
				with (obj_ochrespikes)
					{
						instance_destroy();
					}
				instance_destroy(obj_breakout_ball);
				obj_breakout_paddle.activated=false;
				scr_regionunlock();
				global.ochre_events=scr_event_set_complete(global.ochre_events,OCHRE_EVENTS.BREAKOUT);
				var snd=audio_play_sound(snd_collect_animation,0,false);
				audio_sound_gain(snd,global.sound_fx_volume*global.sound_fx_on,0);
				instance_destroy();
			}
	}