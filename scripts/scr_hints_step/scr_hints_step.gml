//Created 24/09/19
//Last updated 24/09/19
//We'll use the hints events holder to check things

//This manually uses alarms so don't create the alarm events
//The only thing I might suggest is reducing the alarm times

//I am removing these because they're basically redundant
exit;

if global.tips=false or global.hardpause=true or global.softpause=true
	exit;
	
	
if (!instance_exists(obj_timetrial) and scr_event_check_complete(global.hint_events,EVENTS_HINTS.LOWERDIFFICULTY)=false and global.localdeaths>5 and global.difficulty>DIFFICULTY.EXTRAEASY)
	{
		global.hint_events=scr_event_set_complete(global.hint_events,EVENTS_HINTS.LOWERDIFFICULTY);
		scr_queue_notification(scr_return_text(221),NOTIFICATION.HINT);
	}

switch(room)
	{
		case room_EdSpace1_1:
			{
				#region prompt to jump at literally the first ledge + turn off hints notification
				if collision_rectangle(0,608,640,room_height,parent_main_character,false,true) and scr_event_check_complete(global.hint_events,EVENTS_HINTS.HAS_JUMPED)=false
					{
						if scr_event_check_complete(global.hint_events,EVENTS_HINTS.CANTURNOFFHINTS)=false
							{
								global.hint_events=scr_event_set_complete(global.hint_events,EVENTS_HINTS.CANTURNOFFHINTS);
								scr_queue_notification(scr_return_text(222),NOTIFICATION.HINT);
							}
						alarm[0]+=1;
					}
				else
					{
						global.hint_events=scr_event_set_complete(global.hint_events,EVENTS_HINTS.HAS_JUMPED);
					}
				if alarm[0]>450
					{
						alarm[0]=0;
						alarm[1]+=1;
						if alarm[1]%4!=0
							{
								scr_queue_notification(scr_return_text(223), NOTIFICATION.HINT);
							}
						else
							{
								scr_queue_notification(scr_return_text(224),NOTIFICATION.HINT);
							}
					}
				#endregion
				#region prompt to jump further
				if parent_main_character.x=clamp(parent_main_character.x,960,1120) and parent_main_character.y>=room_height-16 and scr_event_check_complete(global.hint_events,EVENTS_HINTS.LONG_JUMP)=false
					{
						scr_queue_notification(scr_return_text(225),NOTIFICATION.HINT);
						global.hint_events=scr_event_set_complete(global.hint_events,EVENTS_HINTS.LONG_JUMP);
					}
				if parent_main_character.x>1120
					{
						global.hint_events=scr_event_set_complete(global.hint_events,EVENTS_HINTS.LONG_JUMP);
					}
				#endregion
				break;
			}
		case room_EdSpace1_2:
			{
				var playerx=parent_main_character.x;
				#region prompt to jump on enemies head
				if playerx=clamp(playerx,0,288) and scr_event_check_complete(global.hint_events,EVENTS_HINTS.ENEMY_JUMP)=false
					{
						alarm[0]+=1;
						if alarm[0]>450
							{
								global.hint_events=scr_event_set_complete(global.hint_events,EVENTS_HINTS.ENEMY_JUMP);
								scr_queue_notification(scr_return_text(226),NOTIFICATION.HINT);
							}
					}
				else
					{
						global.hint_events=scr_event_set_complete(global.hint_events,EVENTS_HINTS.ENEMY_JUMP);
					}
				#endregion
				#region prompt to use Sage to control enemies
				if playerx=clamp(playerx,512,672) and scr_event_check_complete(global.hint_events,EVENTS_HINTS.USED_SAGE)=false
					{
						if instance_number(obj_sage)=0
							{
								alarm[1]+=1;
							}
					}
				if inst_388352EF.x!=inst_388352EF.xstart
					{
						global.hint_events=scr_event_set_complete(global.hint_events,EVENTS_HINTS.USED_SAGE);
					}
				if alarm[1]>450
					{
						alarm[1]=0;
						scr_queue_notification(scr_return_text(227),NOTIFICATION.HINT);
					}
				#endregion
				#region Sage can't go through barriers
				//The status of this event is managed by whenever Ed hits a barrier
				if instance_number(obj_sage)>0 and scr_event_check_complete(global.hint_events,EVENTS_HINTS.SAGE_BARRIER)=false
					{
						var dist;
						with (obj_sage)
							{
								dist=min(distance_to_object(obj_barrier_hor),distance_to_object(obj_barrier_vert));
							}
						if dist<64
							{
								alarm[2]+=1;
							}
					}
				if alarm[2]>300
					{
						alarm[2]=0;
						scr_queue_notification(scr_return_text(228),NOTIFICATION.HINT);
					}
				#endregion
				#region push/pull
				if collision_rectangle(0,992,256,1120,parent_main_character,false,true) and scr_event_check_complete(global.hint_events,EVENTS_HINTS.PUSH_PULL)=false
					{
						alarm[3]+=1;
					}
				if collision_rectangle(0,832,192,864,parent_main_character,false,false) or parent_main_character.state=PlayerState.pushing or parent_main_character.state=PlayerState.pulling
					{
						global.hint_events=scr_event_set_complete(global.hint_events,EVENTS_HINTS.PUSH_PULL);
					}
				
				if alarm[3]>450	
					{
						alarm[3]=0
						scr_queue_notification(scr_return_text(229),NOTIFICATION.HINT);
					}
				#endregion
				break;
			}
		case room_EdSpace1_3:
			{
				#region jump on the moving platform
				if scr_event_check_complete(global.hint_events,EVENTS_HINTS.FLOATING_PLATFORM)=false
					{
						var player=parent_main_character;
						if player.y>1248
							{
								alarm[0]+=1;
							}
					}
				if alarm[0]>600
					{
						scr_queue_notification(scr_return_text(230),NOTIFICATION.HINT);
						alarm[0]=0;
						global.hint_events=scr_event_set_complete(global.hint_events,EVENTS_HINTS.FLOATING_PLATFORM);
					}
				#endregion
				#region note about respawning enemies
				var gloop=inst_6D1B01BC;
				if instance_exists(gloop)
					{
						if gloop.y>gloop.ystart
							{
								global.hint_events=scr_event_set_complete(global.hint_events,EVENTS_HINTS.ENEMY_RESPAWN);
							}
						if scr_event_check_complete(global.hint_events,EVENTS_HINTS.ENEMY_RESPAWN)=false
							{
								if collision_rectangle(1872,880,2048,1024,gloop,false,false)=noone
									{
										scr_queue_notification(scr_return_text(231),NOTIFICATION.HINT);
										global.hint_events=scr_event_set_complete(global.hint_events,EVENTS_HINTS.ENEMY_RESPAWN);
									}
							}
					}
				#endregion
				break;
			}
		case room_EdSpace1_4:
			{
				#region hold away from ledge to jump
				if scr_event_check_complete(global.hint_events,EVENTS_HINTS.HOLDAWAYFROMLEDGE)=false
					{
						var player=parent_main_character;
						var x1=512;
						var y1=1024;
						var x2=672;
						var y2=1248;
						if player.x=clamp(player.x,x1,x2) and player.y=clamp(player.y,y1,y2)
							{
								alarm[0]+=1;
							}
						//Now check if they've succesfully jumped up the ledge
						x1=416;
						y1=896;
						x2=672;
						y2=960;
						if player.x=clamp(player.x,x1,x2) and player.y=clamp(player.y,y1,y2)
							{
								global.hint_events=scr_event_set_complete(global.hint_events,EVENTS_HINTS.HOLDAWAYFROMLEDGE);
							}
					}
				if alarm[0]>300
					{
						scr_queue_notification(scr_return_text(315),NOTIFICATION.HINT);
						alarm[0]=0;
						global.hint_events=scr_event_set_complete(global.hint_events,EVENTS_HINTS.HOLDAWAYFROMLEDGE);
					}
				#endregion
				break;
			}
		case room_EdSpace1_5:
			{
				#region difficulty up
				if (scr_event_check_complete(global.hint_events,EVENTS_HINTS.RAISEDIFFICULTY)=false and global.deaths==0 and global.difficulty<DIFFICULTY.EXTRAHARD)
					{
						global.hint_events=scr_event_set_complete(global.hint_events,EVENTS_HINTS.RAISEDIFFICULTY);
						scr_queue_notification(scr_return_text(232),NOTIFICATION.HINT);
					}
				#endregion
			}
	}