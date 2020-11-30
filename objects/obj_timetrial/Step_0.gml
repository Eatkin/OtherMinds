/// @description

if (global.hardpause==true)
	{
		exit;
	}

if (trialstarted==false)
	{
		var player=parent_main_character;
		if (player.x!=player.xstart or player.y!=player.ystart)
			{
				trialstarted=true;
				switch (room)
					{
						case rm_EdSpace_z1_challenge:
							scr_play_music(mus_edspace1_challenge);
							break;
							
						case rm_OchreHill_challenge:
							scr_play_music(mus_ochre_challenge);
							break;
							
						case rm_EdSpace_z2_challenge:
							scr_play_music(mus_edspace2_challenge);
							break;
					}
			}
	}

//If we've started, add time (IN SECONDS!!)
if (trialstarted==true and trialended==false)
	{
		time+=1/room_speed;
	}
	
if (trialended==true and alarm[0]=-1)
	{
		alarm[0]=120;
		newbesttime=scr_timetrial_updatetimes(time);
		//We need to find the target time and see if we're under it!
		var grid=global.besttimes;
		var gridheight=ds_grid_height(grid);
		//Find the room name
		for (var i=0; i<gridheight; i+=1)
			{
				if (ds_grid_get(grid,BESTTIMES.ROOMNAME,i)==room_get_name(room))
					{
						//Then find the target time
						var targettime=ds_grid_get(grid,BESTTIMES.TARGETTIME,i);
						//Then if we're under the target time if flags the correct event as completed!
						if (time<=targettime)
							{
								var eventref=ds_grid_get(grid,BESTTIMES.REF,i);
								global.timetrials=scr_event_set_complete(global.timetrials,eventref);
							}
					}
			}
	}
if (alarm[0]%10==0)
	{
		blink=blink^1;
	}