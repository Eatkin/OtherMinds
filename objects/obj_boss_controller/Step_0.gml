/// @description Horrible code do not look
// You can write your code in this editor

//If I want to make it harder I can make the cannons randomly fire pink bullets rather than top to bottom
//I can also reduce the laser warning time
//I could also increase the speed of the platforms with each cannon destroyed

if (instance_exists(obj_transition) or global.hardpause==true)
	{
		scr_pause_alarms();
		exit;
	}

//States and things
if state=previousstate
	{
		timeinstate+=1;
	}
else
	{
		previousstate=state;
		timeinstate=0;
	}

//Anyway there's a button that Dr Death presses to change states
if activated=true
	{
		switch (state)
			{
				case BOSS_STATE.INACTIVE:
					{
						//COMMENT OUT BELOW
						/*
						state=BOSS_STATE.PHASETHREE;
						alarm[8]=300;
						obj_boss_platform_controller.platspeed=4;
						break;*/
						//COMMENT OUT ABOVE
						if scr_event_check_complete(global.edspaceevents_one,EVENTS_EDSPACE_ONE.BOSSPHASETWO)=true
							{
								scr_play_music(mus_boss_edspace1);
								state=BOSS_STATE.PHASETHREE;
								alarm[8]=300;
								var platspeed=4;
								if (scr_return_difficulty()>=DIFFICULTY.HARD)
									{
										platspeed+=1;
									}
								if (scr_return_difficulty()<=DIFFICULTY.EASY)
									{
										platspeed-=1;
									}
								obj_boss_platform_controller.platspeed=platspeed;
								if (global.rng==1)
									{
										obj_boss_platform_controller.platspeed=-platspeed;
									}
								break;
							}
						lerpingcannonsin=true;
						break;
					}
				case BOSS_STATE.BREAKONE:
					{
						state=BOSS_STATE.PHASETWO;
						var platspeed=3;
						if (scr_return_difficulty()>=DIFFICULTY.HARD)
							{
								platspeed+=1;
							}
						if (scr_return_difficulty()<=DIFFICULTY.EASY)
							{
								platspeed-=1;
							}
						obj_boss_platform_controller.platspeed=platspeed;
						if (global.rng==1)
							{
								obj_boss_platform_controller.platspeed=-platspeed;
							}
						break;
					}
				case BOSS_STATE.PHASETWO:
					{
						if timeinstate>60
							{
								firelaser=true;
							}
						break;
					}
				case BOSS_STATE.BREAKTWO:
					{
						state=BOSS_STATE.PHASETHREE;
						alarm[8]=300;
						var platspeed=4;
						if (scr_return_difficulty()>=DIFFICULTY.HARD)
							{
								platspeed+=1;
							}
						if (scr_return_difficulty()<=DIFFICULTY.EASY)
							{
								platspeed-=1;
							}
						obj_boss_platform_controller.platspeed=platspeed;
						if (global.rng==1)
							{
								obj_boss_platform_controller.platspeed=-platspeed;
							}
						break;
					}
			}
		activated=false;
	}

/*DEBUG
CHANGE TO ZERO WHEN FINISHED TESTING!*/
var debug=1;
debug=0;

if keyboard_check_pressed(ord("R")) and debug=1
	{
		state+=1;
	}

if global.hardpause=1
	{
		scr_pause_alarms();
		exit;
	}

switch (state)
	{
		case BOSS_STATE.INACTIVE:
			{
				#region inactive
				//Magic numbers (this just corresponds to the main platform
				var countdown=90;
				var cannonyspawn=565;
				if lerpingcannonsin=true
					{
						//We set an alarm to countdown to the boss start
						if alarm[0]=-1
							{
								alarm[0]=countdown;
								scr_play_music(mus_boss_edspace1);
								//Create the cannons
								var i;
								for (i=0; i<3; i+=1)
									{
										cannon[i]=instance_create_layer(832,cannonyspawn+48*i,"objects",obj_boss_cannon);
										with (cannon[i])
											{
												scr_play_sound(snd_cannon_into_wall,false,0);
											}
									}
							}
					}
				if alarm[0]!=-1
					{
						var alarmtimer=alarm[0];
						//Lerp in cannons
						var i;
						var xtarget=cannon[0].xstart-16;
						for (i=0; i<3; i+=1)
							{
								with (cannon[i])
									{
										//These will lerp slightly slower when the y is lower
										//592 is the spawn point of the first cannon
										x=lerp(x,xtarget,0.08*(cannonyspawn/y));
										if abs(x-xtarget)<1
											{
												x=xtarget;
											}
									}
							}
					}
				#endregion inactive
				break;
			}
		case BOSS_STATE.PHASEONE:
			{
				#region phase one cannons
				//Start creating platforms
				//Sorry actually, we don't do that at all, way to go leaving that comment there
				var num=instance_number(obj_platform_bosscontrolled);
				//Min 4, max 6
				var spawnblock=0;
				var spawnx=830;
				//Check if there's a bottom or middle platform available and make one available if nots
				if collision_rectangle(spawnx,620,spawnx-display_get_gui_width(),700,obj_platform_bosscontrolled,0,true)
					{
						var spawny=choose(576,624,672);
					}
				else
					{
						var spawny=choose(624,672);
					}
				
				var maxplats=5;
				if (scr_return_difficulty()>=DIFFICULTY.HARD)
					{
						maxplats-=1;
					}
				if (scr_return_difficulty()<=DIFFICULTY.EASY)
					{
						maxplats+=1;
					}
				if (num<4)
					{
						spawnblock=1;
					}
				else if num=clamp(num,0,maxplats)
					{
						var roll=irandom(60);
						if roll=1
							{
								spawnblock=1;
							}
					}
				/*
				//Do a check to see if a block will overlap in the vertical plane
				if collision_line(832,560,832,704,obj_platform_bosscontrolled,false,true)
					{
						spawnblock=0;
					}
				if spawnblock=1
					{
						//Leave at least a 128 px gap between platform spawns
						var newblock=instance_create_layer(spawnx,spawny,"objects",obj_platform_bosscontrolled);
						//Delete if there's already something there
						with (newblock)
							{
								if place_meeting(x,y,obj_platform_bosscontrolled) or place_meeting(x-64,y,obj_platform_bosscontrolled)
									{
										instance_destroy();
									}
							}
					}*/
				//We need to check all cannons are not destroyed before proceeding here otherwise we'll get stuck in an infinite while loop
				
				//Now we manage the cannons shooting
				//We need to ordinarily shoot bullets but come up with an increasing probability of shooting
				//The pink bullets based on time since a cannon was destroyed
				if !collision_rectangle(spawnx,500,spawnx-64,700,obj_boss_bullets,0,true)
					{
						var timeuntilpinkbullet=60*3; //3 seconds
						var bulletcount=instance_number(obj_boss_bullets);
						var maxbullets=4;
						var platspeed=4;
						if (scr_return_difficulty()>=DIFFICULTY.HARD)
							{
								maxbullets+=1;
							}
						if (scr_return_difficulty()<=DIFFICULTY.EASY)
							{
								maxbullets-=1;
							}
						if bulletcount=clamp(bulletcount,0,maxbullets) and cannonsdestroyed<3
							{
								var newbullet=noone;
								var roll=irandom(60);
								if roll=0
									{
										var cannonnum=irandom(2);
										var counter=0;
										while (cannon[cannonnum].destroyed=true)
											{
												cannonnum=irandom(2);
												counter+=1;
												if counter=10
													{
														break;
													}
											}
										newbullet=instance_create_layer(cannon[cannonnum].x,cannon[cannonnum].y,"objects",obj_boss_bullets);
										var savedcannonnum=cannonnum;
										//Now lets give a chance of turning pink
										if instance_number(obj_pink_bullets)=0
											{
												//This tends towards 0.8 after 180 seconds
												//Time gets shorter and probability greater with less cannons though
												var prob=max(0,sign(cannondestroyedtimer/(cannonsdestroyed+1)-timeuntilpinkbullet))*(0.8-150/(cannondestroyedtimer*(cannonsdestroyed+1)))
												if debug=1
													{
														prob=1;
													}
												if random(1)<prob
													{
														var cannonnum=0;
														var counter=0;
														while (cannon[cannonnum].destroyed=true)
															{
																counter+=1;
																if counter=10
																	{
																		break;
																	}
																cannonnum+=1;
															}
														//This replaces the bullet with a pink one, but it creates it at the highest possible cannon
														//It teleports the old bullet off screen because otherwise it explodes
														with (newbullet)
															{
																x=-1000;
																y=-1000;
															}
														newbullet=instance_create_layer(cannon[cannonnum].x,cannon[cannonnum].y,"objects",obj_pink_bullets);
														instance_create_layer(cannon[cannonnum].x,cannon[cannonnum].y,"objects",obj_smokering);
														var snd=sound_bullet;
														with (cannon[cannonnum])
															{
																scr_play_sound(snd,false,0);
															}
													}
												else
													{
														instance_create_layer(cannon[savedcannonnum].x,cannon[savedcannonnum].y,"objects",obj_smokering);
														var snd=sound_bullet;
														with (cannon[savedcannonnum])
															{
																scr_play_sound(snd,false,0);
															}
													}
											}
										else
											{
												instance_create_layer(cannon[savedcannonnum].x,cannon[savedcannonnum].y,"objects",obj_smokering);
												var snd=sound_bullet;
												with (cannon[savedcannonnum])
													{
														scr_play_sound(snd,false,0);
													}
											}
										newbullet.depth+=1;
									}
							}
						}
				
				//Check if a cannon has been destroyed
				var cannondestroyed=0
				if instance_number(obj_pink_bullets)!=0
					{
						with (obj_pink_bullets)
							{
								if place_meeting(x,y,owner) and state=PlayerState.defeated
									{
										with (owner)
											{
												destroyed=1;
											}
										scr_camera_screenshake_x(2);
										scr_camera_screenshake_y(1);
										instance_destroy();
										cannondestroyed=1;
									}
							}
					}
				cannondestroyedtimer+=1;
				if cannondestroyed=1
					{
						cannonsdestroyed+=1;
						cannondestroyedtimer=0;
					}
				if cannonsdestroyed=3
					{
						state=BOSS_STATE.BREAKONE;
					}
				#endregion phase one
				break;
			}
		case BOSS_STATE.BREAKONE:
			{
				#region break one					
				//lerp in the cannons
				// This is all dumb. We have a countdown, after that countdown the cannons move into the wall
				var countdown=90;
				if alarm[1]=-1
					{
						alarm[1]=countdown;
					}
				if alarm[1]!=-1
					{
						if alarm[1]=0
							{
								//Stop events re-triggering
								alarm[1]=-2;
								alarm[2]=countdown;
								//Cannons start to move into walls now
								for (var i=0; i<3; i+=1)
									{
										with (cannon[i])
											{
												scr_play_sound(snd_cannon_into_wall,false,0);
											}
									}
							}
						if alarm[2]!=-1
							{
								//lerp the cannons in
								var i;
								var cannonyspawn=608;
								for (i=0; i<3; i+=1)
									{
										with (cannon[i])
											{
												//These will lerp slightly slower when the y is lower
												x=lerp(x,xstart+16,0.04*(cannonyspawn/y));
												if abs(x-xstart-16)<2
													{
														instance_destroy();
													}
											}
									}
							}
					}
				#endregion break one
				break;
			}
		case BOSS_STATE.PHASETWO:
			{
				#region PHASE 2 lasers
				//Start off restarting the platforms moving and platform spawning
				//(This is basically the same as the inactive state)
				var countdown=90;
				var cannonyspawn=582;
				if alarm[4]=-1
					{
						alarm[4]=countdown;
						//Create the cannons
						if laser[0]=noone
							{
								var i;
								for (i=0; i<3; i+=1)
									{
										laser[i]=instance_create_layer(832,cannonyspawn+48*i,"objects",obj_laser_cannon);
										laser[i].depth-=1;
										with (laser[i])
											{
												scr_play_sound(snd_cannon_into_wall,false,0);
											}
									}
							}
					}
				if alarm[4]>=0
					{
						var alarmtimer=alarm[4];
						//Lerp in the laser cannons
						var i;
						var xtarget=laser[0].xstart-16;
						for (i=0; i<3; i+=1)
							{
								with (laser[i])
									{
										//These will lerp slightly slower when the y is lower
										//592 is the spawn point of the first cannon
										x=lerp(x,xtarget,0.08*(cannonyspawn/y));
										if abs(x-xtarget)<1
											{
												x=xtarget;
											}
									}
							}
						
						//Stop the alarm to stop the events retriggering
						if alarm[4]=0
							{
								alarm[4]=-2;
							}
					}
				
				#region comments i'll never read
				//Now we have cannons destroyed timer
				//Once this is over 180, we start increasing the chance of a laser firing up to 0.5
				//If a laser fires, it first checks the last 2/3 of the screen for blocks at different heights
				//It picks the height with the most platforms to fire at, if that laser is burnt out it picks a random one
				//Laser begins warming up, set an alarm in the laser cannon to control animation speed too
				//Once platforms stop we get a 0.5s grace before it shoots and disintegrates all the platforms
				//(Make sure we keep all platforms at speed of 0)
				//Make laser's burn out after 2 shots
				
				//Calculate probability
				//This tends towards 0.5
				/*var laserfireprob=max(0,sign(laserdestroyedtimer-180))*(0.5-120/laserdestroyedtimer)
				if alarm[4]=-2
					{
						laserdestroyedtimer+=1;
					}*/
				
				#endregion
				var countdown=60;
				if laseractive=0
					{
						//Attempt to fire a laser
						if firelaser=true
							{
								//If all the lasers are destroyed we move to the next phase
								if lasersdestroyed=3
									{
										//obj_platform_bosscontrolled.xspeed=0;
										state=BOSS_STATE.BREAKTWO;
										global.edspaceevents_one=scr_event_set_complete(global.edspaceevents_one,EVENTS_EDSPACE_ONE.BOSSPHASETWO);
										break;
									}
								var x1=384;
								var x2=736;
								var y1=576
								var y2=592;
								var _numhigh, _nummed, _numlow;
								var _list=ds_list_create();
								_numhigh=collision_rectangle_list(x1,y1,x2,y1,obj_platform_bosscontrolled,false,true,_list,false);
								y1=624;
								y2=640;
								_nummed=collision_rectangle_list(x1,y1,x2,y1,obj_platform_bosscontrolled,false,true,_list,false);
								y1=672;
								y2=688;
								_numlow=collision_rectangle_list(x1,y1,x2,y1,obj_platform_bosscontrolled,false,true,_list,false);
								ds_list_destroy(_list); //We don't need the list
								var lasernum=irandom(2);
								var laserchosen=false;
								repeat (3)
									{
										//Pick the next laser if its burnt out
										if laser[lasernum].alive=false
											{
												lasernum+=1;
												lasernum=lasernum%3;
												continue;
											}
										switch (lasernum)
											{
												case 0:
													{
														if _numlow=0 and _nummed=0
															{
																lasernum+=1;
																lasernum=lasernum%3;
															}
														else
															{
																laserchosen=true;
															}
														break;
													}
												case 1:
													{
														if _numhigh=0 and _numlow=0
															{
																lasernum+=1;
																lasernum=lasernum%3;
															}
														else
															{
																laserchosen=true;
															}
														break;
													}
												case 2:
													{
														if _nummed=0 and _numhigh=0
															{
																lasernum+=1;
																lasernum=lasernum%3;
															}
														else
															{
																laserchosen=true;
															}
														break;
													}
											}
										//We've found a laser that we can use
										if laserchosen=true
											{
												break;
											}
									}
								//Commented stuff out because its managed better now
								//I occasionally get stranded with nowhere to go so lets just make sure there's plenty of platforms
								/*if instance_number(obj_platform_bosscontrolled)<4
									{
										lasernum=-1;
									}*/
								//Check there's more than just the platform
								//Now we have a lasernum to fire we check if its active
								if laserchosen=true
									{
										/*while (laser[lasernum].alive=false)
											{
												lasernum+=1;
												lasernum=lasernum%3;
											}*/
										if laser[lasernum].alive=true
											{
												//Changed the countdown to shorter as you get more warning time
												var countdown=45;
												if (scr_return_difficulty()>=DIFFICULTY.HARD)
													{
														countdown-=15;
													}
												if (scr_return_difficulty()<=DIFFICULTY.EASY)
													{
														countdown+=15;
													}
												laser[lasernum].alarm[0]=countdown; //1 second countdown
												alarm[5]=countdown; //Set our own alarm to the same
												laseractive=1;
											}
									}
								firelaser=false;
							}
						}
					//Now we control what happens when the laser is active
					//(Slow down the platforms to a stop)
					/*if laseractive=1
						{
							obj_platform_bosscontrolled.xspeed=max(3*(alarmtime/countdown),0);
						}*/
					
					#endregion
				break;
			}
		case BOSS_STATE.BREAKTWO:
			{
				#region break two		
				//Platforms already stopped in this state
				var countdown=60;
				if alarm[6]=-1
					{
						for (var i=0; i<3; i+=1)
							{
								var emit=instance_create_layer(x,y,layer,obj_sound_emitter);
								emit.soundid=snd_cannon_into_wall;
							}
						//Stop events re-triggering
						alarm[6]=countdown;
						//Cannons start to move into walls now
						for (var i=0; i<3; i+=1)
							{
								with (laser[i])
									{
										scr_play_sound(snd_cannon_into_wall,false,0);
									}
							}
					}
							
				if alarm[6]!=-1
					{								
						//lerp the laser cannons in
						var i;
						var cannonyspawn=608;
						for (i=0; i<3; i+=1)
							{
								with (laser[i])
									{
										//These will lerp slightly slower when the y is lower
										x=lerp(x,xstart+16,0.04*(cannonyspawn/y));
										if abs(x-xstart-16)<0.5
											{
												instance_destroy();
											}
									}
							}
								
						//Make sure alarm[6] doesn't retrigger
						if alarm[6]=1
							{
								alarm[6]=-2;
							}
					}
				#endregion break one
				break;
			}
		case BOSS_STATE.PHASETHREE:
			{
				#region phase three
				//Also reactivate all the spikes
				if !instance_exists(spikes[29])
					{
						for (i=29; i<56; i+=1)
							{
								instance_activate_object(spikes[i]);
								//Make sure its on top of the platforms
								with (spikes[i])
									{
										depth-=1;
									}
							}
					}
				//Now just manage spikes 29-44 by lerping them to the correct xposition
				var i;
				//X between 384 and 736
				var x1=384;
				var x2=738;
				var xwidth=x2-x1;
				var xfraction=1-(parent_main_character.x-x1)/xwidth; //This should be between 0 and 1
				for (i=29; i<56; i+=1)
					{
						with (spikes[i])
							{
								x=lerp(x,xstart+16*xfraction,0.1);
							}
					}
					
				//Then at the end of alarm[8] we go to the break
				//Dr Death will pick up on the signal and jump on the button again
				if alarm[8]=-1
					{
						state=BOSS_STATE.BREAKTHREE;
					}
				#endregion
				break;
			}
		case BOSS_STATE.BREAKTHREE:
			{
				#region literally just nothing (not literally)
				if alarm[11]=-1
					{
						alarm[11]=180;
					}
				if alarm[11]<170
					{
						state=BOSS_STATE.PHASEFOUR;
						var platspeed=5;
						if (scr_return_difficulty()>=DIFFICULTY.HARD)
							{
								platspeed+=1;
							}
						if (scr_return_difficulty()<=DIFFICULTY.EASY)
							{
								platspeed-=1;
							}
						obj_boss_platform_controller.platspeed=platspeed;
						if (global.rng==1)
							{
								obj_boss_platform_controller.platspeed=-platspeed;
							}
					}
				#endregion
				break;
			}
		case BOSS_STATE.PHASEFOUR:
			{
				#region phase four
				//This is just the same as phase three except faster and for less time
				
				//Start off restarting the platforms moving and platform spawning
				//(This is basically the same as the inactive state)
				//Now just manage spikes 29-44 by lerping them to the correct xposition
				var i;
				//X between 384 and 736
				var x1=384;
				var x2=738;
				var xwidth=x2-x1;
				var xfraction=1-(parent_main_character.x-x1)/xwidth; //This should be between 0 and 1
				for (i=29; i<56; i+=1)
					{
						with (spikes[i])
							{
								x=lerp(x,xstart+16*xfraction,0.1);
							}
					}
					
				//Then at the end of alarm[11] we go to the break
				if alarm[11]=-1
					{
						state=BOSS_STATE.BREAKFOUR;
						//Deactivate the laser
						with (obj_boss_laser)
							{
								numberofflashes=8;
								alarm[0]=flashtime;
								state=BARRIER.DISAPPEAR;
							}
					}
				#endregion
				break;
			}
		case BOSS_STATE.BREAKFOUR:
			{
				#region break four
				//Lerp away spikes
				for (i=29; i<56; i+=1)
					{
						if instance_exists(spikes[i])
							{
								with (spikes[i])
									{
										x=lerp(x,xstart,0.1);
										if x-xstart<0.1
											{
												instance_deactivate_object(id);
											}
									}
							}
					}
					
				//Reset platform speed - nah don't its fun
				//obj_boss_platform_controller.platspeed=2;
				#endregion
				break;
			}
		case BOSS_STATE.DEFEATED:
			{
				scr_regionunlock();
				obj_boss_platform_controller.platspeed=0;
				with (parent_main_character)
					{
						if state!=PlayerState.defeated and state!=PlayerState.dead
							{
								global.edspaceevents_one=scr_event_set_complete(global.edspaceevents_one,EVENTS_EDSPACE_ONE.BOSSDEFEATED);
								scr_todo_complete(3);
							}
					}
				
				//I just want to cycle through the platforms and see if there's any that we need to 'dispose' of
				for (var i=0; i<instance_number(obj_platform_bosscontrolled);i+=1)
					{
						var inst=scr_instance_nth_nearest(x,y,obj_platform_bosscontrolled,i+1);
						if inst!=noone
							{
								with (inst)
									{
										if x<384
											{
												x=lerp(x,-sprite_width,0.1);
												if scr_on_camera()=false
													{
														instance_destroy();
														break;
													}
											}
										if x>832-sprite_width
											{
												x=lerp(x,room_width,0.1);
												if scr_on_camera()=false
													{
														instance_destroy();
														break;
													}
											}
									}
							}
					}
					
				//We need to make a platform available to jump up if one isn't available
				if  platform[0]=noone and collision_rectangle(640,608,832,640,obj_platform_bosscontrolled,false,true)=noone
					{
						platform[0]=instance_create_layer(752,720,"Objects",obj_platform_bosscontrolled);
					}
				if platform[0]!=noone and platform[0].y!=624
					{
						with (platform[0])
							{
								y=lerp(y,624,0.05);
								if abs(y-624)<1
									{
										y=624;
									}
							}
					}
				break;
			}
		}
		
#region health drops
if (scr_return_difficulty()<DIFFICULTY.HARD and state>BOSS_STATE.INACTIVE)
	{
		var player=parent_main_character;
		var probNum=0; //Impossible to spawn a heart at first
		if (player.hp!=player.hpmax and instance_number(obj_heart)==0)
			{
				probNum=1;
			}
		var probDen=10000;
		//Various things that make probDen smaller, i.e. make the probability larger
		probDen-=(1000*(player.hpmax-player.hp));
		probDen-=500*max(global.localdeaths*0.2,4);
		//Highest probability is when you have no health and you've died 40 times (lol)
		if (random(1)<=(probNum/probDen))
			{
				var xSpawn=irandom_range(416,640);
				instance_create_layer(xSpawn,720,"objects",obj_heart);
			}
	}
#endregion

#region arena spikes
//Manage the spikes
//I know I'm not supposed to use 'magic numbers' but this corresponds to the hole at the bottom
//Of the boss arena
var timermax=45;
if (scr_return_difficulty()>=DIFFICULTY.HARD)
	{
		timermax-=25;
	}
if (scr_return_difficulty()<=DIFFICULTY.EASY)
	{
		timermax+=15;
	}
if (collision_line(384,734,768,734,parent_main_character,false,true)!=noone or collision_line(384,734,768,734,obj_drdeath_edspaceboss,false,true) or spikestimer=clamp(spikestimer,0,timermax-1)) and state!=BOSS_STATE.DEFEATED
	{
		//Show spikes as warning
		if spikestimer=clamp(spikestimer,15,timermax) and spikes[0].y>=spikes[0].ystart-4
			{
				var i;
				for (i=0; i<23; i+=1)
					{
						with (spikes[i])
							{
								y=lerp(y,ystart-4,0.4);
							}
					}
			}
		//Eject spikes upwards
		//Includes some screenshake
		else
			{
				var i;
				for (i=0; i<23; i+=1)
					{
						with (spikes[i])
							{
								if y!=ystart-16
									{
										y=lerp(y,ystart-16,0.5);
										if abs(y-ystart)>15
											{
												y=ystart-16;
												//Play sound at the middle spike
												if i=11
													{
														scr_set_vibration(1,1,20);
														scr_camera_screenshake_y(2);
														var snd=audio_play_sound(snd_spikes_eject,0,0);
														audio_sound_gain(snd,global.sound_fx_volume*global.sound_fx_on,0);
													}
											}
									}
							}
					}
			}
		spikestimer-=1;
	}
else
	{
		spikestimer=timermax;
		var i;
		if spikes[0].y!=ystart
			{
				if spikes[0].y=ystart-4
					{
						for (i=0; i<23; i+=1)
							{
								with (spikes[i])
									{
										y=ystart;
									}
							}	
					}
				else
					{
						for (i=0; i<23; i+=1)
							{
								with (spikes[i])
									{
										y=lerp(y,ystart,0.1);
									}
							}
					}
			}
	}
#endregion

#region Dr Death's spikes (unused)
/*
var lerptarget;
var lerpamount=0.4;
var i=23;
switch (deathspikesstate)
	{
		case BOSSSPIKE_STATE.THREATEN:
			{
				lerptarget=spikes[i].ystart-4;
				break;
			}
		case BOSSSPIKE_STATE.EXPOSED:
			{
				lerptarget=spikes[i].ystart-16;
				lerpamount=0.1;
				break;
			}
		case BOSSSPIKE_STATE.RETRACTING:
			{
				lerptarget=spikes[i].ystart;
				lerpamount=0.05;
				break;
			}
		
		case BOSSSPIKE_STATE.RETRACTED:
			{
				lerptarget=spikes[i].ystart;
				break;
			}
	}
	
//Now lerp the spikes

var spikestate=deathspikesstate;
if spikes[i].y!=lerptarget
	{
		for (i=23; i<29; i+=1)
			{
				with (spikes[i])
					{
						y=lerp(y,lerptarget,lerpamount);
						if abs(y-lerptarget)<1
							{
								y=lerptarget;
								if spikestate=BOSSSPIKE_STATE.RETRACTING
									{
										spikestate=BOSSSPIKE_STATE.RETRACTED;
									}
								if spikestate=BOSSSPIKE_STATE.EXPOSED
									{
										if i=26
											{
												scr_camera_screenshake_y(2);
												var snd=audio_play_sound(snd_spikes_eject,0,0);
												audio_sound_gain(snd,global.sound_fx_volume*global.sound_fx_on,0);
											}
									}
							}
					}
			}
	}
deathspikesstate=spikestate;*/
#endregion