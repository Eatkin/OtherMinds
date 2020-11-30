/// @description State machine
// You can write your code in this editor

// Inherit the parent event
event_inherited();

scr_states_step();

if (instance_exists(obj_transition))
	{
		exit;
	}

//Behaviour stuff will go here!
if state=PlayerState.dead and died=false
	{
		died=true;
		obj_boss_controller.state=BOSS_STATE.DEFEATED;
		scr_play_music(mus_edspace1_outdoors);
	}

if state=PlayerState.defeated and scr_inventory_check(obj_masterplan,localinventory) and scr_event_check_complete(global.edspaceevents_one,EVENTS_EDSPACE_ONE.COLLECTEDMASTERPLAN)=0
	{
		//Eject the master plan
		instance_create_layer(x,y,"objects",obj_masterplan);
		scr_inventory_remove(obj_masterplan,localinventory);
	}

if global.currentinstance=id or global.hardpause=true
	{
		exit;
	}

var bossstate=obj_boss_controller.state;

var buttonstateadvance=inst_78A32E37;
var platformbutton=inst_33559A3B;

switch (bossstate)
	{
		case BOSS_STATE.INACTIVE:
			{
				#region
				var player=parent_main_character;
				if player.x!=clamp(player.x,512,512+3*32) and bossstarted=false
					{
						break;
					}
				else
					{
						if alarm[0]=-1 and bossstarted=false
							{
								//Force a laugh
								timeinstate=240;
								waiting=true;
								bossstarted=true;
								//First lock the region then press the button
								with (obj_boss_controller)
									{
										scr_regionlock(384,room_height-270,true);
									}
								alarm[0]=60;
								with (global.currentinstance)
									{
										scr_todo_discover(3);
									}
							}
					}
				//Then press button to activate cannons
				var _dir=sign(buttonstateadvance.x-x);
				if alarm[0]=-1
					{
						s_hinput=_dir;
						if place_meeting(x,y,buttonstateadvance)
							{
								s_hinput=0;
							}
						if xspeed=0 and directionfacing=1
							{
								s_hinput=-1;
							}
					}
				break;
				#endregion
			}
		case BOSS_STATE.PHASEONE:
			{
				#region
				//Jump up to the platform button
				//This moves towards it, jumps if it detects a block, then jumps up if we're on a ledge
				var _dir=sign(platformbutton.x-x);
				s_hinput=_dir;
				
				if place_meeting(x,platformbutton.y,platformbutton)
					{
						s_hinput=0;
					}
				
				//Won't jump???!!!?
				if place_meeting(x+_dir*8,y,obj_solid) and state!=PlayerState.air and s_hinput!=0
					{
						var roll=irandom(10);
						//Always jump when colliding with a wall
						if place_meeting(x+_dir,y,obj_solid)
							{
								roll=0;
							}
						if roll=0
							{
								s_jump=true;
							}
					}
				if state=PlayerState.air and y>platformbutton.y
					{
						s_jumphold=true;
					}
				if state=PlayerState.ledgegrab
					{
						if irandom(60)=0
							{
								s_jump=true;
							}
					}
				if place_meeting(x,platformbutton.y,platformbutton)
					{
						if directionfacing=1
							{
								s_hinput=-1;
							}
					}
				break;
				#endregion
			}
		case BOSS_STATE.BREAKONE:
			{
				#region
				//First he waits until the cannons are lerped in fully (about 1.5 seconds)
				if instance_exists(obj_boss_cannon)
					{
						break;
					}
				//So we just need to check if we can jump down and jump down to the buttonstateadvance button
				//These are the rectangle coords I need to check for a collission between
				var x1=768;
				var y1=576;
				var x2=832;
				var y2=704;
				//Jump down to the state advance button
				if landedonplatform=false
					{
						var _dir=sign(buttonstateadvance.x-x);
						if collision_rectangle(x1,y1,x2,y2,obj_platform_bosscontrolled,false,true)=noone and state!=PlayerState.air and y<544
							{
								s_hinput=_dir
								if irandom(6)=0
									{
										s_jump=true;
									}
								//Cliff detection
								if !position_meeting(bbox_left,y+1,obj_solid)
									{
										s_jump=true;
									}
							}
						if state=PlayerState.air
							{
								s_hinput=_dir;
								if place_meeting(x,buttonstateadvance.y,buttonstateadvance)
									{
										s_hinput=0;
										//Tap left to face the right direction
										if directionfacing=1
											{
												s_hinput=1;
											}
									}
							}
						else if y>544
							{
								s_hinput=_dir;
								if place_meeting(x,y,buttonstateadvance)
									{
										s_hinput=0;
									}
							}
					}
				else
					{
						if (place_meeting(buttonstateadvance.x,y,buttonstateadvance))
							{
								//We can be in a situation where there's a platform above the button, so let's jump back up if there is
								if (collision_line(x,y,buttonstateadvance.x,buttonstateadvance.y,obj_platform_bosscontrolled,false,true)==noone)
									{
										landedonplatform=false;
										break;
									}
							}
						var _dir=sign(platformbutton.x-x);
						s_hinput=_dir;
						//Jump
						if place_meeting(x+_dir*8,y,obj_solid) and state!=PlayerState.air and s_hinput!=0
							{
								var roll=irandom(10);
								//Always jump when colliding with a wall
								if place_meeting(x+_dir,y,obj_solid)
									{
										roll=0;
									}
								if roll=0
									{
										s_jump=true;
									}
							}
						if state=PlayerState.air and y>platformbutton.y
							{
								s_jumphold=true;
							}
						if state=PlayerState.ledgegrab
							{
								if irandom(60)=0
									{
										s_jump=true;
									}
							}
						if place_meeting(x,y,platformbutton) and state=PlayerState.idle
							{
								landedonplatform=false;
							}
					}
					
				//Now there's a small chance a platform will inexplicably appear below our feet and we'll have to repeat this
				if place_meeting(x,y+1,obj_platform_bosscontrolled)
					{
						landedonplatform=true;
					}
				break;
				#endregion
			}
		case BOSS_STATE.PHASETWO:	
			{
				#region
				//This is mostly copy and paste code
				//He jumps up to hit the platform switch for 3-6 seconds
				//Probability of jumping to fire a laser increases up to 5 seconds
				//Some flag gets set and he'll jump down when there's a gap
				//If he hits a platform on the way down it overrides it and he moves it out the way
				//So he just needs to jump down then jump up
			
				//Jump up
				if firingalaser=false
					{
						if place_meeting(x,y,platformbutton)
							{
								laserfiretimer+=1;
							}
						//The probability increases the more cannons are destroyed
						var cannonsdestroyed=obj_boss_controller.lasersdestroyed;
						var prob=max((laserfiretimer/(cannonsdestroyed+1)-180)/180,0);
						if cannonsdestroyed=3
							{
								prob=max(laserfiretimer-180,0)
							}
						if random(1)<prob
							{
								firingalaser=true;
							}
					
						//Now jumpup to the platform if we're not there
						var _dir=sign(platformbutton.x-x);
						s_hinput=_dir;
						
						if place_meeting(x,platformbutton.y,platformbutton)
							{
								s_hinput=0;
							}
				
						if place_meeting(x+_dir*8,y,obj_solid) and state!=PlayerState.air and s_hinput!=0
							{
								var roll=irandom(10);
								//Always jump when colliding with a wall
								if place_meeting(x+_dir,y,obj_solid)
									{
										roll=0;
									}
								if roll=0
									{
										s_jump=true;
									}
							}
						if state=PlayerState.air and y>platformbutton.y
							{
								s_jumphold=true;
							}
						if state=PlayerState.ledgegrab
							{
								if irandom(60)=0
									{
										s_jump=true;
									}
							}
						if place_meeting(x,y,platformbutton)
							{
								if directionfacing=1
									{
										s_hinput=-1;
									}
							}
					}
				else if landedonplatform=false//Jump down to smash that mf laser button
					{
						var x1=768;
						var y1=576;
						var x2=832;
						var y2=704;
						var _dir=sign(buttonstateadvance.x-x);
						if collision_rectangle(x1,y1,x2,y2,obj_platform_bosscontrolled,false,true)=noone and state!=PlayerState.air and y<544
							{
								s_hinput=_dir
								if irandom(6)=0
									{
										s_jump=true;
									}
								//Cliff detection
								if !position_meeting(bbox_left,y+1,obj_solid)
									{
										s_jump=true;
									}
							}
						if state=PlayerState.air
							{
								s_hinput=_dir;
								if position_meeting(x,buttonstateadvance.y,buttonstateadvance)
									{
										s_hinput=0;
										//Tap left to face the right direction
										if directionfacing=1
											{
												s_hinput=1;
											}
									}
							}
						else if y>544
							{
								s_hinput=_dir;
								if place_meeting(x,y,buttonstateadvance)
									{
										s_hinput=0;
									}
								if xspeed=0 and directionfacing=1
									{
										s_hinput=-1;
									}
							}
						if place_meeting(x,y,buttonstateadvance) and state!=PlayerState.air
							{
								//We have to use timeonbutton because there's a single frame that the laser isn't counted as active
								var active=obj_boss_controller.laseractive;
								if irandom(6)=0 and active=false and timeonbutton>0
									{
										laserfiretimer=0;
										firingalaser=false;
									}
								else
									{
										//Get the instance id of the third laser
										var lasertocheck;
										with (obj_boss_controller)
											{
												lasertocheck=laser[2];
											}
										if lasertocheck.alarm[0]!=-1 or lasertocheck.alarm[1]!=-1 or lasertocheck.mylaser!=noone
											{
												s_vinput=-1;
											}
									}
								timeonbutton+=1;
							}
						if !place_meeting(x,y,buttonstateadvance)
							{
								timeonbutton=0;
							}
					}
			
				//Land on a platform and remedy the situation here
				if place_meeting(x,y+1,obj_platform_bosscontrolled)
					{
						landedonplatform=true;
					}
				if landedonplatform=true
					{
						if (place_meeting(buttonstateadvance.x,y,buttonstateadvance))
							{
								//We can be in a situation where there's a platform above the button, so let's jump back up if there is
								if (collision_line(x,y,buttonstateadvance.x,buttonstateadvance.y,obj_platform_bosscontrolled,false,true)!=noone)
									{
										firingalaser=false;
									}
								landedonplatform=false;
							}
						var _dir=sign(platformbutton.x-x);
						s_hinput=_dir;
						
				
						//Jump
						if place_meeting(x+_dir*8,y,obj_solid) and state!=PlayerState.air and s_hinput!=0
							{
								var roll=irandom(10);
								//Always jump when colliding with a wall
								if place_meeting(x+_dir,y,obj_solid)
									{
										roll=0;
									}
								if roll=0
									{
										s_jump=true;
									}
							}
						if state=PlayerState.air and y>platformbutton.y
							{
								s_jumphold=true;
							}
						if state=PlayerState.ledgegrab
							{
								if irandom(60)=0
									{
										s_jump=true;
									}
							}
						if place_meeting(x,y,platformbutton) and state=PlayerState.idle
							{
								landedonplatform=false;
							}
					}
				break;
				#endregion
			}
		case BOSS_STATE.BREAKTWO:
			{
				#region
				//We just perform a small jump
				if state!=PlayerState.air
					{
						s_jump=true;
					}
				break;
				#endregion
			}
		case BOSS_STATE.PHASETHREE:
			{
				#region
				//Jump up to the button
				//Copied from Phase one
				//Jump up to the platform button
				//This moves towards it, jumps if it detects a block, then jumps up if we're on a ledge
				var _dir=sign(platformbutton.x-x);
				s_hinput=_dir;
				if place_meeting(x,platformbutton.y,platformbutton)
					{
						s_hinput=0;
					}
				
				//Won't jump???!!!?
				if place_meeting(x+_dir*8,y,obj_solid) and state!=PlayerState.air and s_hinput!=0
					{
						var roll=irandom(10);
						//Always jump when colliding with a wall
						if place_meeting(x+_dir,y,obj_solid)
							{
								roll=0;
							}
						if roll=0
							{
								s_jump=true;
							}
					}
				if state=PlayerState.air and y>platformbutton.y
					{
						s_jumphold=true;
					}
				if state=PlayerState.ledgegrab
					{
						if irandom(60)=0
							{
								s_jump=true;
							}
					}
				if place_meeting(x,platformbutton.y,platformbutton)
					{
						if directionfacing=1
							{
								s_hinput=-1;
							}
					}
				break;
				#endregion
			}
		case BOSS_STATE.BREAKTHREE:
			{
				#region
				//We just perform a jump
				if state!=PlayerState.air
					{
						s_jump=true;
					}
				else
					{
						s_jumphold=true;
					}
				break;
				#endregion
			}
		case BOSS_STATE.PHASEFOUR:
			{
				#region literally nothing
				break;
				#endregion
			}
		case BOSS_STATE.BREAKFOUR:
			{
				#region
				//Here we want to jump around trying to get to Ed and jump on his head
				/*Short plan!
				We want to jump away from the button for a start and make a map of where the platforms are
				We want to chase Ed around but make sure we land safely at the same time and not in the spike pit
				We attempt to jump at him
				Make sure jump attemps are a 1/60 chance or similar because if they aren't then the boss will be OP
				He can have a few states - attacking, fleeing and waiting
				Attacking means Ed is close and he's on a safe platform and he's been waiting
				If Ed is grounded it increases his chances of an attack
				Fleeing means he has to go find a safe platform - if he takes a hit we will go to this and if we fall on the ground we will do this
				Waiting is when Ed is too far away and we're on a safe platform
				*/
				//We'll jump off the button if we're attacking
				if place_meeting(x,y,platformbutton)
					{
						s_jump=true;
					}
				var Ed=instance_nearest(x,y,parent_main_character);
				var _dir=sign(Ed.x-x);
				var maxjumpheight=scr_calculate_jumpheight();
				if state=PlayerState.air
					{
						maxjumpheight=scr_calculate_jumpheight(abs(yspeed));
						if yspeed>0
							{
								maxjumpheight=0;
							}
					}
				var Edx=Ed.x;
				var Edy=Ed.bbox_top; //We use the bbox_top so Dr Death tries to jump above
				//I'm going to do a two-part xreach equation
				var xreach=(abs(jumpheight/global.gravstrength*0.75))*(maxxspeed-1)+abs(xspeed);
				if state=PlayerState.air
					{
						xreach=abs(yspeed/global.gravstrength*0.75)*(maxxspeed-1)+abs(xspeed);
						if yspeed>0
							{
								xreach=0;
							}
					}
				
				//What we need to do is to find all reachable platforms, then target which one is most favourable (the one that we can most easily reach Ed from)
				//We only want to find most favourable platforms when we are standing on a platform
				//If we are close to Ed in x and y, we try and jump on him
				//Every time we reach a platform, we randomly wait for a time before moving on
				//If there's no safe platforms, we jump to the right
				//If the arena spikes are about to attack us, we jump straight away
				
				//Here we select a platform - we set rules for which we can jump to
				//Are they close enough? In the x plane and the y plane
				//We find the nearest reachable platform that is closest to Ed
				//If he's over to the right we move to the platforms on the right
				//Platform can be destroyed
				if !instance_exists(targetplatform)
					{
						targetplatform=noone;
					}
					
					
				#region find target platform
				if targetplatform=noone and (state=PlayerState.idle or state=PlayerState.running) and targettinged=false
					{
						var platnum=instance_number(obj_platform_bosscontrolled)
						if platnum>0
							{
								for (var i=0; i<platnum; i+=1)
									{
										var plat=scr_instance_nth_nearest(x,y,obj_platform_bosscontrolled,i+1);
										if place_meeting(x,y+1,plat)
											{
												continue;
											}
										if targetplatform=noone
											{
												//Check we can actually reach the platform
												//Update xreach
												//First we calculate how many steps at terminal velocity we will take
												var steps=((y-plat.y)-(scr_calculate_jumpheight(abs(yspeed))))/maxyspeed;
												steps=max(steps,0);
												//Then we add on how many steps we will take getting to terminal velocity
												steps+=(maxyspeed-yspeed)/(global.gravstrength*0.75);
												//Add on how many steps it takes to get up if we're moving upwards
												steps+=scr_calculate_jumpheight()/(global.gravstrength*0.75);
												var platx=plat.x+plat.sprite_width*0.5-steps*plat.xspeed+steps*maxxspeed;
												if y>plat.y
													{
														var xreach_2=xreach+steps*maxxspeed;
													}
												else
													{
														var xreach_2=xreach*2;
													}
												if y-plat.y<maxjumpheight and abs(x-platx)<xreach_2
													{
														targetplatform=plat;
														continue;
													}		
												continue;
											}
											
										//Now we can see if there's a more favourable platform available
										//Check we can actually reach the platform
										//In this case we continue the loop if its not	
										//calculate how many steps at terminal velocity we will take
										var steps=((y-plat.y)-(scr_calculate_jumpheight(abs(yspeed))))/maxyspeed;
										steps=max(steps,0);
										//Then we add on how many steps we will take getting to terminal velocity
										steps+=(maxyspeed-yspeed)/(global.gravstrength*0.75);
										//Add on how many steps it takes to get up if we're moving upwards
										steps+=scr_calculate_jumpheight()/(global.gravstrength*0.75);
										var platx=plat.x+plat.sprite_width*0.5-steps*plat.xspeed;
										if y>plat.y
											{
												//First we calculate how many steps at terminal velocity we will take
												var steps=((y-plat.y)-(scr_calculate_jumpheight(abs(yspeed))))/maxyspeed;
												steps=max(steps,0);
												//Then we add on how many steps we will take getting to terminal velocity
												steps+=(maxyspeed-yspeed)/(global.gravstrength*0.75);
												var xreach_2=xreach+steps*maxxspeed;
											}
										else
											{
												var xreach_2=xreach*2;
											}
										if y-plat.y>=maxjumpheight or abs(x-platx)>=xreach_2
											{
												continue;
											}
										
										//Now plat has passed the checks
										//Define platx and platy
										var platwidth=sprite_get_width(obj_platform_bosscontrolled.sprite_index);
										var platx=targetplatform.x+targetplatform.sprite_width*0.5-steps*targetplatform.xspeed;
										var platy=targetplatform.y;
										//Adjust platx
										if Edx=clamp(Edx,platx,platx+platwidth)
											{
												platx=Edx;
											}
										else if Edx>platx
											{
												platx+=platwidth;
											}
										var _1stdist=point_distance(Edx,Edy,platx,platy);
										
										//Now do the same with the new platform
										var platx=plat.x+plat.sprite_width*0.5-steps*plat.xspeed;
										var platy=plat.y;
										//Adjust platx
										if Edx=clamp(Edx,platx,platx+platwidth)
											{
												platx=Edx;
											}
										else if Edx>platx
											{
												platx+=platwidth;
											}
										
										var _2nddist=point_distance(Edx,Edy,platx,platy);
										
										if _2nddist<_1stdist
											{
												targetplatform=plat;
											}
									}
								/*This shows which platform has been targetted
								if targetplatform!=noone
									{
										instance_create_layer(targetplatform.x,targetplatform.y,layer,obj_smoke);
									}
									*/
							}
					}
				#endregion
				
				//Now we need to see if the target platform is noone
				//If it is we just jump over to the right and the loop will execute every step until it finds a target platform
				//If we're sufficiently close to Ed we try and jump on him (random chance)
				//This will override trying to jump on the target platform
				
				if state=PlayerState.ledgegrab
					{
						if irandom(30)=0
							{
								s_jump=true;
							}
					}
				if state=PlayerState.air
					{
						s_jumphold=true;
					}
				if state=PlayerState.cliffedge or state=PlayerState.pushing
					{
						s_jump=true;
						//He got stuck jumping up and down like an idiot once
						if xspeed=0
							{
								s_hinput=sign(Edx-x);
								targettingplatform=false;
								targetplatform=noone;
							}
					}
				//Jump off platforms
				if !place_meeting(x+2*xspeed,y+1,obj_platform_bosscontrolled) and !place_meeting(x+2*xspeed,y+1,obj_solid) and state!=PlayerState.air
					{
						s_jump=true;
						//He got stuck jumping up and down like an idiot once
						if xspeed=0
							{
								s_hinput=sign(Edx-x);
								targettingplatform=false;
								targetplatform=noone;
							}
					}
				
				//Find if Ed is close enough to try and jump on
				var jumponed=false;
				if y-Edy<maxjumpheight
					{
						jumponed=true;
					}
				if y>Edy
					{
						//First we calculate how many steps at terminal velocity we will take
						var steps=((y-Edy)-(scr_calculate_jumpheight(abs(yspeed))))/maxyspeed;
						steps=max(steps,0);
						//Then we add on how many steps we will take getting to terminal velocity
						steps+=(maxyspeed-yspeed)/(global.gravstrength*0.75);
						var xreach_2=xreach+steps*maxxspeed;
					}
				else
					{
						var xreach_2=xreach*2;
					}
				if abs(x-Edx)>=xreach_2
					{
						jumponed=false;
					}
				
				if jumponed=false
					{
						targettinged=false;
					}
				if jumponed=true and targettingplatform=false
					{
						_dir=sign(Edx-x);
						targettinged=true;
						if state!=PlayerState.air
							{
								var roll=1;
								if place_meeting(x,Edy,Ed)
									{
										roll=irandom(10);
									}
								if roll=0
									{
										s_jump=true;
									}
							}
						s_hinput=_dir;
						//This ensures we don't waggle back and forth
						if place_meeting(x,Edy,Ed)
							{
								s_hinput=0;
							}
					}
				else if targetplatform=noone and targettinged=false
					{
						targettingplatform=false;
						
						//Chase Ed but run right if we can't reach him
						if y-Edy-sprite_get_height(Ed)<maxjumpheight
							{
								_dir=sign(Edx-x);
							}
						else
							{
								_dir=1;
							}
							
						s_hinput=_dir;
						//Stand safely if we can't reach Ed
						if x>752 and y-Edy-sprite_get_height(Ed)>=maxjumpheight and state!=PlayerState.air
							{
								s_hinput=0;
								if directionfacing!=sign(Edx-x)
									{
										s_hinput=-sign(Edx-x);
									}
							}
						if place_meeting(x+xspeed,y,obj_solid)
							{
								s_jump=true;
							}
						/*if x>800
							{
								s_hinput=-1;
							}*/
					}
				else if targettinged=false
					{
						targettingplatform=true;
						var plat=targetplatform;
						//Steps at terminal velocity
						var steps=((y-plat.y)-(scr_calculate_jumpheight(abs(yspeed))))/maxyspeed;
						steps=max(steps,0);
						//Then we add on how many steps we will take getting to terminal velocity
						steps+=(maxyspeed-yspeed)/(global.gravstrength*0.75);
						//Add on how many steps it takes to get up if we're moving upwards
						steps+=scr_calculate_jumpheight()/(global.gravstrength*0.75);
						var targetx=plat.x+plat.sprite_width*0.5-plat.xspeed*steps;
						//Jump to the target platform
						_dir=sign(targetx-x);
						s_hinput=_dir;
						if place_meeting(x,plat.y,plat)
							{
								s_hinput=_dir*sign(plat.xspeed);
								if bbox_bottom>plat.y and state!=PlayerState.air
									{
										//Roll for a jump
										if irandom(30)=0
											{
												s_jump=true;
											}
									}
							}
						if instance_position(x,bbox_bottom+1,plat) and state!=PlayerState.air
							{
								targettingplatform=false;
								targetplatform=noone;
							}
						//We need to cancel platforms we can no longer reach
						if targetplatform!=noone and state!=PlayerState.air
							{
								var lostplatform=false;
								if y-plat.y>=maxjumpheight and state!=PlayerState.air
									{
										lostplatform=true;
									}
								//Check if it is still reachable
								if y>plat.y
									{
										//First we calculate how many steps at terminal velocity we will take
										var steps=((y-plat.y)-(scr_calculate_jumpheight(abs(yspeed))))/maxyspeed;
										steps=max(steps,0);
										//Then we add on how many steps we will take getting to terminal velocity
										steps+=(maxyspeed-yspeed)/global.gravstrength;
										var xreach_2=xreach+steps*maxxspeed;
									}
								else
									{
										var xreach_2=xreach*2;
									}
								if abs(x-targetx)>xreach_2
									{
										lostplatform=true;
									}
								
								if lostplatform=true
									{
										targetplatform=noone;
										targettingplatform=false;
									}
							}
					}
				
				//Final check to make sure he doesn't get skewered
				if place_meeting(x,y+4,obj_spikes)
					{
						s_jump=true;
					}
				
				break;
				#endregion
			}
	}