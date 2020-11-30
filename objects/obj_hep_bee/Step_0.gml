/// @description States and stuff
// You can write your code in this editor

event_inherited();

if (instance_exists(obj_transition))
	{
		exit;
	}

if (state==PlayerState.defeated)
	{
		interactwithblocksenabled=false;
	}

scr_states_step();

//Why doesn't this work?
if (soundplaying==noone)
	{
		scr_play_sound(snd_bee_buzz,true,0);
	}

var bosstate=obj_boss_controller_HepBee.state;

if (global.currentinstance==id)
	{
		var player=parent_main_character;
		if (bosstate==BOSS_STATE.INACTIVE and player.x!=clamp(player.x,0,480))
			{
				player.x=120;
				player.y=1500;
				//Teleport them in
				with (player)
					{
						state=PlayerState.teleport;
						sprite_index=sprite_teleport_backwards;
						image_index=0;
						image_speed=1;
					}
				scr_queue_notification(scr_return_text(422),NOTIFICATION.HINT)
			}
		exit;
	}

switch (bosstate)
	{
		case BOSS_STATE.INACTIVE:
			{
				//Just hold up to make sure we stay in the air
				var ymin=1380;
				var ymax=1420;
				if (y>ymax)
					{
						s_jumphold=true;
					}
				if (y>ymin)
					{
						s_vinput=1;
					}
				//Now patrol
				s_hinput=patroldir;
				var xmin=150
				var xmax=400;
				if (x!=clamp(x,xmin,xmax))
					{
						//Positive for x<xmax, negative for x>=xmax
						patroldir=scr_sign_nonzero(xmax-x);
					}
				break;
			}
		case BOSS_STATE.PHASEONE:	
			{
				//What's actually happening here is he's swooping down and shooting, which I like
				//I should actually make that INTENTIONAL though
				//So patrol, the swoop down and shoot a bee
				if (patrolling==true)
					{
						//Just hold up to make sure we stay in the air
						var ymin=1350;
						var ymax=1400;
						if (swooping==false and inhoney==false)
							{
								if (y>ymax)
									{
										s_jumphold=true;
									}
								if (y>ymin)
									{
										s_vinput=1;
									}
								if (y<ymin)
									{
										s_vinput=-1;
									}
							}
						
						if (swooping==true or inhoney==true)
							{
								var ymin=1400;
								var ymax=1500;
								if (inhoney==true)
									{
										ymin+=100;
										ymax+=100;
									}
								if (y<ymax)
									{
										s_vinput=-1;
									}
								if (y==clamp(y,ymin,ymax))
									{
										s_vinput=1;
									}
								if (y>ymax)
									{
										s_vinput=1;
										s_jumphold=true;
									}
							}
						if (iframes==30)
							{
								s_b_four=true;
								var roll=irandom(10);
								if (roll==0)
									{
										patroldir=-patroldir;
										swooping=false;
										inhoney=false;
									}
							}
						//Now patrol
						s_hinput=patroldir;
						var xmin=96;
						var xmax=384;
						//Random chance of flipping direction early
						var roll=irandom(128);
						if (roll==0)
							{
								xmin+=64
								xmax-=64;
							}
						if (x!=clamp(x,xmin,xmax))
							{
								//Positive for x<xmax, negative for x>=xmax
								patroldir=scr_sign_nonzero(xmax-x);
							}
						var xshotmin=250;
						var xshotmax=300;
						if (x=clamp(x,xshotmin,xshotmax))
							{
								s_b_four=true;
								var roll=irandom(60);
								if (inhoney==true)
									{
										roll=irandom(15);
									}
								if (roll==0)
									{
										swooping=false;
										inhoney=false;
									}
							}
							
						var swooprange=64;
						if (abs(x-xmin)<swooprange or abs(x-xmax)<swooprange)
							{
								if (swooping==false and inhoney==false)
									{
										var roll=irandom(56); //This is APPROXIMATELY 1/4 PATROLS
										if (roll==0)
											{
												roll=irandom(1);
												if (roll==0)
													{
														swooping=true;
													}
												else
													{
														inhoney=true;
													}
											}
									}
							}
					}
				break;
			}
		case BOSS_STATE.BREAKONE:
			{
				//Just hold up to make sure we stay in the air
				var ymin=1050;
				var ymax=1100;
				if (y>ymax)
					{
						s_jumphold=true;
					}
				if (y>ymin)
					{
						s_vinput=1;
					}
				//Now patrol
				s_hinput=patroldir;
				var xmin=150
				var xmax=400;
				if (x!=clamp(x,xmin,xmax))
					{
						//Positive for x<xmax, negative for x>=xmax
						patroldir=scr_sign_nonzero(xmax-x);
					}
				break;
			}
		case BOSS_STATE.PHASETWO:
			{
				#region repeat of break one for 2 seconds while the player has recovery time
				if (phasetwotimer>0)
					{
						phasetwotimer-=1;
						//Just hold up to make sure we stay in the air
						var ymin=1050;
						var ymax=1100;
						if (y>ymax)
							{
								s_jumphold=true;
							}
						if (y>ymin)
							{
								s_vinput=1;
							}
						//Now patrol
						s_hinput=patroldir;
						var xmin=150
						var xmax=400;
						if (x!=clamp(x,xmin,xmax))
							{
								//Positive for x<xmax, negative for x>=xmax
								patroldir=scr_sign_nonzero(xmax-x);
							}
						break;
					}
				#endregion
				//Here we want to patrol at 4 levels and randomly pick them
				//Also same dealio with the shooting
				//So patrolling is highest
				//Swooping is mid
				//Inhoney is below honey
				//So basically we give probabilites as in Phase One
				//But we essentially pick a height to fly to based on state
				//Then instead of randomly shooting, we will randomly shoot if in line with Ed's y pos
				
				var ymin=1050;
				var ymax=1100;
				if (swooping==true)
					{
						ymin=1150;
						ymax=1200;
					}
				if (inhoney==true)
					{
						ymin=1250;
						ymax=1300;
					}
					
				if (y>ymax)
					{
						s_jumphold=true;
					}
				if (y>ymin)
					{
						s_vinput=1;
					}
				if (y<ymin)
					{
						s_vinput=-1;
					}
				
				//Turn around when hit and shoot
				if (iframes==30)
					{
						s_b_four=true;
						var roll=irandom(10);
						if (roll==0)
							{
								patroldir=-patroldir;
								swooping=false;
								inhoney=false;
							}
					}
				//Now patrol
				s_hinput=patroldir;
				var xmin=96;
				var xmax=384;
				//Random chance of flipping direction early
				var roll=irandom(128);
				if (roll==0)
					{
						xmin+=64
						xmax-=64;
					}
				if (x!=clamp(x,xmin,xmax))
					{
						//Positive for x<xmax, negative for x>=xmax
						patroldir=scr_sign_nonzero(xmax-x);
					}
				var xshotmin=250;
				var xshotmax=300;
				var edy=parent_main_character.y;
				if (x=clamp(x,xshotmin,xshotmax))
					{
						if (y==clamp(y,edy-32,edy+32))
							{
								s_b_four=true;
							}
						var roll=irandom(60);
						if (inhoney==true or swooping==true)
							{
								roll=irandom(15);
							}
						if (roll==0)
							{
								swooping=false;
								inhoney=false;
							}
					}
							
				var swooprange=64;
				if (abs(x-xmin)<swooprange or abs(x-xmax)<swooprange)
					{
						if (swooping==false and inhoney==false)
							{
								var roll=irandom(56); //This is APPROXIMATELY 1/4
								if (roll==0)
									{
										roll=irandom(1);
										if (roll==0)
											{
												swooping=true;
											}
										else
											{
												inhoney=true;
											}
									}
							}
					}
				break;
			}
		case BOSS_STATE.BREAKTWO:
			{
				//Just hold up to make sure we stay in the air
				var ymin=950;
				var ymax=1000;
				if (y>ymax)
					{
						s_jumphold=true;
					}
				if (y>ymin)
					{
						s_vinput=1;
					}
				//Now patrol
				s_hinput=patroldir;
				var xmin=150
				var xmax=400;
				if (x!=clamp(x,xmin,xmax))
					{
						//Positive for x<xmax, negative for x>=xmax
						patroldir=scr_sign_nonzero(xmax-x);
					}
				break;
			}
		case BOSS_STATE.PHASETHREE:	
			{
				#region repeat of break one for 2 seconds while the player has recovery time
				if (phasethreetimer>0)
					{
						phasethreetimer-=1;
						//Just hold up to make sure we stay in the air
						var ymin=950;
						var ymax=1000;;
						if (y>ymax)
							{
								s_jumphold=true;
							}
						if (y>ymin)
							{
								s_vinput=1;
							}
						//Now patrol
						s_hinput=patroldir;
						var xmin=150
						var xmax=400;
						if (x!=clamp(x,xmin,xmax))
							{
								//Positive for x<xmax, negative for x>=xmax
								patroldir=scr_sign_nonzero(xmax-x);
							}
						break;
					}
				#endregion
				//Here we want to patrol at 4 levels and randomly pick them
				//Also same dealio with the shooting
				//So patrolling is highest
				//Swooping is mid
				//Inhoney is below honey
				//So basically we give probabilites as in Phase One
				//But we essentially pick a height to fly to based on state
				//Then instead of randomly shooting, we will randomly shoot if in line with Ed's y pos
				
				var ymin=950;
				var ymax=1000;
				if (swooping==true)
					{
						ymin=1050;
						ymax=1100;
					}
				if (inhoney==true)
					{
						ymin=1150;
						ymax=1200;
					}
					
				if (y>ymax)
					{
						s_jumphold=true;
					}
				if (y>ymin)
					{
						s_vinput=1;
					}
				if (y<ymin)
					{
						s_vinput=-1;
					}
				
				//Turn around when hit and shoot
				if (iframes==30)
					{
						s_b_four=true;
						var roll=irandom(10);
						if (roll==0)
							{
								patroldir=-patroldir;
								swooping=false;
								inhoney=false;
							}
					}
				//Now patrol
				s_hinput=patroldir;
				var xmin=96;
				var xmax=384;
				//Random chance of flipping direction early
				var roll=irandom(128);
				if (roll==0)
					{
						xmin+=64
						xmax-=64;
					}
				if (x!=clamp(x,xmin,xmax))
					{
						//Positive for x<xmax, negative for x>=xmax
						patroldir=scr_sign_nonzero(xmax-x);
					}
				var xshotmin=250;
				var xshotmax=300;
				var edy=parent_main_character.y;
				if (x=clamp(x,xshotmin,xshotmax))
					{
						if (y==clamp(y,edy-32,edy+32))
							{
								s_b_four=true;
							}
						var roll=irandom(60);
						if (inhoney==true)
							{
								roll=irandom(15);
							}
						if (roll==0)
							{
								swooping=false;
								inhoney=false;
							}
					}
							
				var swooprange=64;
				if (abs(x-xmin)<swooprange or abs(x-xmax)<swooprange)
					{
						if (swooping==false and inhoney==false)
							{
								var roll=irandom(56); //This is APPROXIMATELY 1/4
								if (roll==0)
									{
										roll=irandom(1);
										if (roll==0)
											{
												swooping=true;
											}
										else
											{
												inhoney=true;
											}
									}
							}
					}
				break;
			}
	}