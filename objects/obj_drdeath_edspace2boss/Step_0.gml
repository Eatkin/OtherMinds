/// @description State machine
// You can write your code in this editor

// Inherit the parent event
event_inherited();

scr_states_step();


if (global.hardpause)
	exit;
//VERY IMPORTANT REMEMBER:
//There's a block in the top left corner, it flips the toggle blocks every time grav inverts and goes back

var player=parent_main_character;

switch (bossState)
	{
		case BOSS_STATE.INACTIVE:
			//Check if player is in the region to trigger the boss start and break if not
			if (player.x<416 and !bossStarted)
				break;
			//This just triggers the boss to laugh and then start the main fight
			if (!bossStarted)
				{
					scr_play_music(myMusic);
					timeinstate=240;
					waiting=true;
					bossStarted=true;
					scr_regionlock(300,704+32-270,true);		//I CAN do math good and I don't not turn off capslock. My grammar am good too/
					//Discover the "defeat dr d" event
					with (global.currentinstance)
						scr_todo_discover(21);
				}
			else
				{
					bossStartCountdown-=1;
					if (bossStartCountdown<0 and player.x>400)
						{
							//Shift camera further right
							bossState=BOSS_STATE.PHASEONE;
							scr_regionunlock();
							scr_regionlock(400,704+32-270,true);
						}
				}
			break;
			
		case BOSS_STATE.PHASEONE:
			//Store the array index of the button
			var buttonIndex=0;
			if (hitButton&power(2,buttonIndex)==0 and x<button[buttonIndex].x+64)
				s_hinput=1;				//Move to the right
			else						//If we have already hit the button we have some other boring conditions but first
				{						//I will make Dr Death face in the direction of the player
					//We already have player index storedas local var player
					var targetDir=scr_sign_nonzero(player.x-x);
					if (directionfacing!=targetDir)
						s_hinput=targetDir;
					if (global.gravdirection==90)
						{
							bossState=BOSS_STATE.BREAKONE;
							genericTimer=0;
							break;
						}
						
					//Generic timer update
					genericTimer+=1;
					//Create one saw obstacle
					if (genericTimer==30 or genericTimer==120 or genericTimer==240)
						{
							var saw=instance_create_layer(1120,592,layer,obj_saw);		//Arbitrary coordinates, but this is slightly to the right
							saw.image_yscale=-1;										//But enough that we don't hear it loudly straight away
							saw.xstart=-500;		//Make sure it moves to the left
							saw.dir=-1;
							var diff=scr_return_difficulty();
							if (diff<DIFFICULTY.NORMAL)
								saw.maxspeed=5;
							else if (diff==DIFFICULTY.NORMAL)
								saw.maxspeed=8;
							else
								saw.maxspeed=12;
								
							saw.maxspeed+=floor(genericTimer/60);		//These get faster with each iteration
						}
				}
				
			//Set the bit mask if we hit the button
			if (place_meeting(x,y,button[buttonIndex].object_index))
				hitButton=hitButton|power(2,buttonIndex);
			break;
			
		case BOSS_STATE.BREAKONE:
			//Run right
			s_hinput=1;
			if (x>880-64)
				scr_regionunlock();
			
			//Jump when meeting a block
			if (place_meeting(x+xspeed*3,y,obj_block))
				s_jump=true;
			
			if (state=PlayerState.air)
				s_jumphold=true;
			
			//Exit state once past a certain point
			if (x>1312)
				bossState=BOSS_STATE.PHASETWO;
			break;
			
		case BOSS_STATE.PHASETWO:
			var buttonIndex=1;
			//Here we wait for the player to enter the platform chamber and go stand on the button
			//If player leaves again we let go and follow them along a bit
			if (player.x>928)
				{
					if (!phaseTwoRegionLocked and player.x>948)
						{
							phaseTwoRegionLocked=true;
							scr_regionlock(940,room_height-270,true);
						}
					//Move towards button 2
					if (!(instance_place(x,y,obj_button_hold_on)==button[buttonIndex]))
						{
							var dist=button[buttonIndex].x-x;
							s_hinput=scr_sign_nonzero(dist);
							//Half s_hinput if we're very close
							if (abs(dist)<xspeed*0.5)
								s_hinput*=0.5;
						}
					else
						{
							//Just turn around to face towards Ed
							if (directionfacing==1)
								s_hinput=-1;
						}
				}
			else
				{
					if (x>1264)
						s_hinput=-1;
				}
				
			if (player.x>1392 and global.gravdirection!=90)
				{
					bossState=BOSS_STATE.BREAKTWO;
					scr_regionunlock();
				}
			break;
			
		case BOSS_STATE.BREAKTWO:
			//Run over to x=2304
			if (x<2096)
				s_hinput=1;
			else
				{
					if (directionfacing==-1)
						s_hinput=-1;
						
					if (player.x>2048)				//If player and boss are sufficiently far right, go to next phase
						{
							//Turn around
							bossState=BOSS_STATE.PHASETHREE;
							scr_regionlock(2035,496,true);
							genericTimer=0;
						}
				}
			break;
		
		case BOSS_STATE.PHASETHREE:
			if (global.gravdirection==90)
				phaseThreeGravNormal=true;
				

			//We need to hold a button to activate the platform spawner
			//Then use genericTimer to decide when to have lasers come across the screen
			if (phaseThreeGravNormal)
				{
					if (!lasersCreated)
						{
							//Go stand on button[2]
							var butt=instance_place(x,y,button[2].object_index);
							if (butt!=button[2])
								{
									var dist=button[2].x-x;
									s_hinput=scr_sign_nonzero(dist);
									//Half s_hinput if we're very close
									if (abs(dist)<xspeed*0.5)
										s_hinput*=0.5;
								}
					
							if (genericTimer==30 or genericTimer==120 or genericTimer==240)
								{
									var laser=instance_create_layer(2608,608,layer,obj_office_laser);		//Arbitrary coordinates, but this is slightly to the right									//But enough that we don't hear it loudly straight away
									laser.xstart=-500;		//Make sure it moves to the left
									laser.dir=-1;
									var diff=scr_return_difficulty();
									if (diff<DIFFICULTY.NORMAL)
										laser.maxspeed=1;
									else if (diff==DIFFICULTY.NORMAL)
										laser.maxspeed=2;
									else
										laser.maxspeed=3;
								
									laser.maxspeed+=floor(genericTimer/60);		//These get faster with each iteration

									if (genericTimer==240)
										{
											lasersCreated=true;
											genericTimer=0;
										}
								}
						}
					else if (genericTimer>300)
						{
							//Now move over to the right and one slow laser, so climb to be protected
							//Go stand on button[3] - we need to step over it, so just target past it
							var targetx=button[3].x+32;
							if (x<targetx)
								s_hinput=1;
							else if (directionfacing==1)
								s_hinput=-1;
								
							if (instance_exists(obj_edspace2LiftPlatform))
								{
									with (obj_edspace2LiftPlatform)
										if (x==clamp(x,1936,2520))		//Arbitrary coordinates based on the region lock
											xspeed=lerp(xspeed,-20,0.2);
								}
							
							
							if (genericTimer==360)
								{
									phaseThreeSlowLaser=instance_create_layer(1936,608,layer,obj_office_laser);		//Arbitrary coordinates, but this is slightly to the right									//But enough that we don't hear it loudly straight away
									var laser=phaseThreeSlowLaser;		//For easy reference
									laser.xstart=room_width;		//Make sure it moves to the right
									laser.dir=1;
									//Set speed based on difficulty
									var diff=scr_return_difficulty();
									if (diff<DIFFICULTY.NORMAL)
										laser.maxspeed=1;
									else if (diff==DIFFICULTY.NORMAL)
										laser.maxspeed=2;
									else
										laser.maxspeed=3;
								}
						}
					genericTimer+=1;
					
					if (phaseThreeSlowLaser!=noone)
						{
							if (phaseThreeSlowLaser.x>2688)		//I.e. is it off screen?
								{
									instance_destroy(phaseThreeSlowLaser);
									phaseThreeSlowLaser=noone;
									scr_regionunlock();
									bossState=BOSS_STATE.BREAKTHREE;
								}
						}
				}
			break;
			
		case BOSS_STATE.BREAKTHREE:
			//Starting from checkpoint, play music
			if (!bossStarted)
				{
					scr_play_music(myMusic);
					bossStarted=true;
				}
				
			//Run to the right and jump up until he gets to a certain point
			if (!breakThreeFirstPos)
				{
					if (x<3328)
						{
							s_hinput=1;
							var xcheck=x+max(s_hinput,xspeed*3);
							if (place_meeting(xcheck,y,obj_solid))
								s_jump=true;
							if (state==PlayerState.air)
								s_jumphold=true;
						}
					else
						{
							if (directionfacing==1)
								s_hinput=-1;
							else if (player.x>3248)
								breakThreeFirstPos=true;
						}
				}
			else if (!breakThreeSecondPos)
				{
					if (x<3936)
						s_hinput=1;
					else
						{
							if (directionfacing==1)
								s_hinput=-1;
							else if (player.x>4000)
								breakThreeSecondPos=true;
						}
				}
			
			if (breakThreeSecondPos)
				{
					if (x<4144)
						s_hinput=1;
					var xcheck=max(1,xspeed*3);
					//Jump!
					if (place_meeting(x+xcheck,y,obj_solid))
						s_jump=true;
						
					if (x>4112 and player.x>4112)
						{
							bossState=BOSS_STATE.PHASEFOUR;
							scr_regionlock(4096,200,true);
						}
				}
			break;
			
		case BOSS_STATE.PHASEFOUR:
			var floory=288;		//Y co-ords of cloor
			var regionLeft=4096;
			var chunkSize=160;
			//We'll cycle through attacks, then defences
			var changeButton=(irandom(aggression)==0)	?	true	:	false;
			if (player.x==clamp(player.x,regionLeft,regionLeft+chunkSize-1))
				{
					if (changeButton)
						targetButton=button[4];
				}
			if (player.x==clamp(player.x,regionLeft+chunkSize,regionLeft+chunkSize*2))
				{
					if (changeButton)
						targetButton=button[5];
				}
			if (player.x>regionLeft+chunkSize*2)
				{
					if (changeButton)
						targetButton=button[6];
				}
			
			if (targetButton!=noone)
				{
					var targetx=targetButton.x;
					var dist=targetx-x;
					var dir=scr_sign_nonzero(dist);
					s_hinput=dir;
					if (abs(dist)<48)
						s_hinput*=0.5;
					if (place_meeting(x,y,targetButton))
						targetButton=noone;
				}
				
			//Now defences
			var evade=(irandom(evasion)==0)	?	true	:	false;
			if (collision_line(x-range,floory+8,x+range,floory+8,obj_saw,false,true)!=noone)
				{
					if (state!=PlayerState.air and evade)
						s_jump=true;
					//If we're falling, try to avoid landing on saw
					if (yspeed>0)
						{
							var saw=instance_place(x,floory,obj_saw);
							if (saw!=noone)
								s_hinput=-scr_sign_nonzero(saw.dir);		//Move in the opposite direction to the saw
						}
				}
			if (collision_line(x-range,floory,x+range,floory,obj_cannon_ball,false,true)!=noone)
				{
					if (state!=PlayerState.air and evade)
						s_jump=true;
					//If we're falling, try and land on the ball
					if (yspeed>0)
						{
							var balls=instance_place(x,floory,obj_cannon_ball);
							if (balls!=noone)
								{
									var dist=balls.x-x;
									s_hinput=scr_sign_nonzero(dist);
								}
						}
				}
			
			var bombRange=26;	//Actually slightly higher than bomb range
			if (collision_line(x-bombRange,floory,x+bombRange,floory,obj_bomb_block,false,true)!=noone)
				{
					var bomb=instance_nearest(x,y,obj_bomb_block);
					if (bomb.explodetimer<60 and evade)
						{
							s_jump=true;
							//Choose direction - 4320 is the coordinates of the centre bomb
							var dir=1;
							if (x<4320)
								dir=-1;
							
							s_hinput=dir;
						}
				}
				
			//Finally avoid falling bombs
			if (instance_exists(obj_bomb_block))
				{
					var avoidBomb=false;
					with (obj_bomb_block)
						if (place_meeting(x,floory,obj_drdeath_edspace2boss))
							avoidBomb=true;
					
					//Run to the left
					if (avoidBomb)
						s_hinput=-1;
				}
				
			//Finally we jump over any obstacles i.e. bomb
			if (place_meeting(x+s_hinput*16,y,obj_solid))
				s_jump=true;
				
			if (state==PlayerState.dead)
				{
					//Complete the defeated boss event
					global.edSpaceTwoEvents=scr_event_set_complete(global.edSpaceTwoEvents,EdSpaceTwoEvents.DEFEATEDDRD);
					
					scr_regionunlock();
					bossState=BOSS_STATE.DEFEATED;
					with (obj_block_on)
						instance_destroy();
					with (obj_block_off)
						instance_destroy();
						
					instance_create_layer(1008,720,"objects",obj_edspace2LiftPlatform);
					instance_create_layer(1152,672,"objects",obj_edspace2LiftPlatform);
					instance_create_layer(1296,624,"objects",obj_edspace2LiftPlatform);
					
					//Activate the grav invert button
					instance_activate_object(inst_C97CC9F);
					
					with (global.currentinstance)
						scr_todo_complete(21);
				}
			break;
	}