/// @description

if global.hardpause=true
	{
		exit;
	}
	
var honeyspeed=1;
var diff=scr_return_difficulty();
/* Yeah get rid of this because Ed phases through platforms and I can't be bothered to fix it
The boss is brutal enough
if (diff>=DIFFICULTY.HARD)
	{
		honeyspeed=2;
	}*/

//Update block coords
if (instance_exists(baseblock))
	{
		with (baseblock)
			{
				y=obj_camera.yfix+obj_camera.thecamheight-global.helpbar*sprite_get_height(spr_HUD_box);
				y+=1;
			}
	}

if state=BOSS_STATE.INACTIVE
	{
		if (honeyrising==false)
			{
				//See if the player is within some arbitrary x bounds
				var playerx=parent_main_character.x;
				if (playerx==clamp(playerx,80,352))
					{
						with (global.currentinstance)
							{
								scr_todo_discover(15);
							}
						//Start rising the honeys
						honeyrising=true;
						//We can manually change yfix when we move level up later
						scr_regionlock(0,room_height-270,true);
						scr_play_music(mus_hep_bee);
						with (obj_music)
							{
								if (nowplaying==noone)
									{
										var song=musicarray[MUSIC.SOUND_ID,8];
										nowplayingsong=song;
										nowplaying=audio_play_sound(song,0,false);
									}
							}
						risingsound=audio_play_sound(snd_shake,0,true);
					}
			}
		else
			{
				/*Honey wants to reach 1488
				Camera wants to be pegged to 32px past honey*/
				//Raise up honey
				with (honey)
					{
						y-=honeyspeed
					}
				//Peg platforms to honey's y
				//This needs to manually move the yunperturbed position
				//Then move anything on top with it
				#region DON'T READ THIS PLEASE - FROM ANGRY ED
				var honeyy=honey.y;
				for (var i=0; i<platformNumber; i+=1)
					{
						with (platform[i])
							{
								//This gets the y position and removes the perturbation
								//Umm I think it does
								//"Do a little platform bob when something lands on it" I said, "it'll be easy" I said
								
								/*ASCII DIAGRAM TIME!!
										YU
										| <-PERT
										Y
										=> PERT=Y-YU; <- this is positive ALWAYS
										AND ITS ALSO NOT USED!!
								WE WANT YU TO BE AT MIN(YU,HONEYY-4)
								SO - WE FIND DY AS THE CHANGE IN YU
								THEN Y-=DY
								*/
								var dy=yunperturbed;
								yunperturbed=min(yunperturbed,honeyy-2);
								//YUNPERTURBED CAN ONLY BE MOVED TO A SMALLER VALUE, SO DY IS ALWAYS POSITIVE!
								dy-=yunperturbed;
								
								//What the fuck am I doing
								yspeed=-dy;
							}
					}
				#endregion
				scr_camera_screenshake_x(2);
				var vib=(sin(honeyy/3)*0.3+0.7);
				scr_set_vibration(vib,vib,1);
				if (honeyy<=1488)
					{
						audio_stop_sound(risingsound);
						state=BOSS_STATE.PHASEONE;
						honeyrising=false;
						for (var i=0; i<platformNumber; i+=1)
							{
								with (platform[i])
									{
										yspeed=0;
									}
							}
					}
			}
	}
if state=BOSS_STATE.PHASEONE
	{
		var hepbee=obj_hep_bee;
		var hbhp=hepbee.hp;
		if (hbhp<=4)
			{
				state=BOSS_STATE.BREAKONE;
				with (hepbee)
					{
						canhurtenabled=false;
						canbehurtenabled=false;
					}
			}
	}
if (state==BOSS_STATE.BREAKONE)
	{
		if (honeyrising==false)
			{
				//See if the player is within some arbitrary x bounds
				var playerx=parent_main_character.x;
				honeyrising=true;
				risingsound=audio_play_sound(snd_shake,0,true);
			}
		else
			{
				/*Honey wants to reach 1218
				Camera wants to be pegged to 32px past honey*/
				//Raise up honey
				with (honey)
					{
						y-=honeyspeed
					}
				with (obj_camera)
					{
						yfix-=honeyspeed;
					}
				//Peg platforms to honey's y
				//This needs to manually move the yunperturbed position
				//Then move anything on top with it
				#region DON'T READ THIS PLEASE - FROM ANGRY ED
				var honeyy=honey.y;
				for (var i=0; i<platformNumber; i+=1)
					{
						with (platform[i])
							{
								//This gets the y position and removes the perturbation
								//Umm I think it does
								//"Do a little platform bob when something lands on it" I said, "it'll be easy" I said
								
								/*ASCII DIAGRAM TIME!!
										YU
										| <-PERT
										Y
										=> PERT=Y-YU; <- this is positive ALWAYS
										AND ITS ALSO NOT USED!!
								WE WANT YU TO BE AT MIN(YU,HONEYY-4)
								SO - WE FIND DY AS THE CHANGE IN YU
								THEN Y-=DY
								*/
								var dy=yunperturbed;
								yunperturbed=min(yunperturbed,honeyy-2);
								//YUNPERTURBED CAN ONLY BE MOVED TO A SMALLER VALUE, SO DY IS ALWAYS POSITIVE!
								dy-=yunperturbed;
								
								//What the fuck am I doing
								yspeed=-dy;
							}
					}
				#endregion
				scr_camera_screenshake_x(2);
				var vib=(sin(honeyy/3)*0.3+0.7);
				scr_set_vibration(vib,vib,1);
				if (honeyy<=1218)
					{
						audio_stop_sound(risingsound);
						state=BOSS_STATE.PHASETWO;
						honeyrising=false;
						for (var i=0; i<platformNumber; i+=1)
							{
								with (platform[i])
									{
										destroyed=true;
										yspeed=0;
									}
							}
						//Re-enable hurting
						with (obj_hep_bee)
							{
								canbehurtenabled=true;
								canhurtenabled=true;
							}
						//Create platform spawners
						//These spawn with horizontal movement
						var spawner_1=instance_create_layer(x,y,layer,obj_platform_spawner);
						var spawner_2=instance_create_layer(x,y,layer,obj_platform_spawner);
						var spawner_3=instance_create_layer(x,y,layer,obj_platform_spawner);
						var hSpeed=2;
						if (diff>=DIFFICULTY.HARD)
							{
								hSpeed=3;
							}
						else if (diff<=DIFFICULTY.EASY)
							{
								hSpeed=1;
							}
						with (spawner_1)
							{
								spawnx=-48;
								spawny=1218-16
								spawn_xspeed=hSpeed;
								spawn_minx=-49;
								spawn_maxx=480;
								spawnrate=0;
								spawnratemax=35;
								if (diff<=DIFFICULTY.EASY)
									{
										spawnratemax*=2;
									}
							}
						with (spawner_2)
							{
								spawnx=480;
								spawny=1218-64;
								spawn_xspeed=-hSpeed;
								spawn_minx=-49;
								spawn_maxx=481;
								spawnrate=10;
								spawnratemax=40;
								if (diff<=DIFFICULTY.EASY)
									{
										spawnratemax*=2;
									}
							}
						with (spawner_3)
							{
								spawnx=-48;
								spawny=1218-112;
								spawn_xspeed=hSpeed;
								spawn_minx=-49;
								spawn_maxx=481;
								spawnrate=20;
								spawnratemax=45;
								if (diff>=DIFFICULTY.HARD)
									{
										spawnratemax=90;
									}
							}
					}
			}
	}
if (state==BOSS_STATE.PHASETWO)
	{
		var hepbee=obj_hep_bee;
		var hbhp=hepbee.hp;
		if (hbhp<=1)
			{
				state=BOSS_STATE.BREAKTWO;
				with (hepbee)
					{
						canhurtenabled=false;
						canbehurtenabled=false;
					}
			}
	}
if (state==BOSS_STATE.BREAKTWO)
	{
		if (honeyrising==false)
			{
				risingsound=audio_play_sound(snd_shake,0,true);
				var playerx=parent_main_character.x;
				honeyrising=true;
				if (diff<DIFFICULTY.HARD)
					{
						var spawner=instance_create_layer(x,y,layer,obj_platform_spawner);
						with (spawner)
							{
								spawnx=480;
								spawny=1218-160;
								spawn_xspeed=-3;
								spawn_minx=-49;
								spawn_maxx=481;
								spawnrate=0;
								spawnratemax=30;
								if (diff<=DIFFICULTY.EASY)
									{
										spawnratemax*=2;
										spawn_xspeed+=1;
									}
							}
					}
			}
		else
			{
				/*Honey wants to reach 1218
				Camera wants to be pegged to 32px past honey*/
				//Raise up honey
				with (honey)
					{
						y-=honeyspeed;
					}
				with (obj_camera)
					{
						yfix-=1;
					}
				//Peg platforms to honey's y
				//This needs to manually move the yunperturbed position
				//Then move anything on top with it
				var honeyy=honey.y;
				scr_camera_screenshake_x(2);
				var vib=(sin(honeyy/3)*0.3+0.7);
				scr_set_vibration(vib,vib,1);
				if (honeyy<=1122)
					{
						audio_stop_sound(risingsound);
						state=BOSS_STATE.PHASETHREE;
						honeyrising=false;
						//Re-enable hurting
						with (obj_hep_bee)
							{
								canbehurtenabled=true;
								canhurtenabled=true;
							}
					}
			}
	}
if (state==BOSS_STATE.PHASETHREE)
	{
		var hepbee=obj_hep_bee;
		var hbstate=hepbee.state;
		if (hbstate==PlayerState.defeated)
			{
				with (obj_hep_bee)
					{
						var gun=instance_create_layer(x,y+gunyoffset,"players",obj_gunfall);
						gun.xspeed=sign(xspeed);
						with (global.currentinstance)
							{
								scr_todo_complete(15);
							}
					}
				state=BOSS_STATE.BREAKTHREE;
			}
	}
if (state==BOSS_STATE.BREAKTHREE)
	{
		if (honeyrising==false)
			{
				honeyrising=true;
				risingsound=audio_play_sound(snd_shake,0,true);
				if (instance_exists(obj_deadlyhoney_hurtmask))
					{
						instance_destroy(obj_deadlyhoney_hurtmask);
					}
				instance_destroy(obj_platform_spawner);
				with (obj_music)
					{
						audio_stop_sound(nowplaying);
						nowplaying=noone;
					}
			}
		else
			{
				with (honey)
					{
						y+=2;
					}
				with (obj_camera)
					{
						yfix+=2;
					}
				//Peg platforms to honey's y
				//This needs to manually move the yunperturbed position
				//Then move anything on top with it
				var honeyy=honey.y;
				var honeyy=honey.y;
				scr_camera_screenshake_x(2);
				var vib=(sin(honeyy/3)*0.3+0.7);
				scr_set_vibration(vib,vib,1);
				if (honeyy>room_height)
					{
						scr_regionunlock();
						instance_destroy(baseblock);
						audio_stop_sound(risingsound);
						state=BOSS_STATE.DEFEATED;
						honeyrising=false;
						scr_play_music(mus_ochre_2);
						//Create platforms between y=640-1456
						//Yspacing of 64
						//So we want to create 12 platforms
						//0 at middle, 1 at left, 2 at middle, 3 at right etc
						var xspawn=-96;
						var yspacing=64;
						var ypos=1456; //So platforms should be 64+yspacing*i
						for (var i=0; i<12; i+=1)
							{
								platform[i]=instance_create_layer(xspawn,ypos-yspacing*i,"objects",obj_honeyplatform);
								platform[i].minx=-97;
							}
						global.ochre_events=scr_event_set_complete(global.ochre_events,OCHRE_EVENTS.HEP_BEE_DEFEATED)
					}
			}
	}
	
if (state==BOSS_STATE.DEFEATED)
	{
		var lerpamount=0;
		var xspawn=80;
		var xspacing=4.5*32;
		var imod=0;
		//Lerp them into position!
		for (var i=0; i<12; i+=1)
			{
				with (platform[i])
					{
						imod=i%4;
						lerpamount=lerp(x,xspawn+xspacing*abs(imod-1),0.05)-x;
						lerpamount=ceil(lerpamount);
						xspeed=lerpamount;
					}
			}
	}



if (state<BOSS_STATE.DEFEATED)
	{
		var honeyy=honey.y;
		//Peg camera
		with (obj_camera)
			{
				yfix=min(room_height-thecamheight,honeyy+64-thecamheight+sprite_get_height(spr_HUD_box)*global.helpbar);
			}
	}