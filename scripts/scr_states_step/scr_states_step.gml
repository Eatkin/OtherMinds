//Created 06/10/19
//Last updated 06/10/19

//exit if paused
if global.hardpause=1
	{
		image_speed=0;
		exit;
	}
else
	{
		image_speed=1;
	}

//Check if we can move (alternative to deactivating)
var cam=view_camera[0];
var camx=camera_get_view_x(cam);
var camy=camera_get_view_y(cam);
var camw=camera_get_view_width(cam);
var camh=camera_get_view_height(cam);

var x1=camx-camw*0.5;
var x2=camx+camw*1.5;
var y1=camy-camh*0.5;
var y2=camy+camh*1.5;

var gravMultiplier=(global.gravdirection==90)	?	1 : -1;

if x!=clamp(x,x1,x2) or y!=clamp(y,y1,y2)
	{
		if state=PlayerState.dead
			{
				scr_state_dead();
				exit;
			}
		if global.currentinstance!=id and moveoffscreenenabled=false
			{
				exit;
			}
	}
	
scr_set_canmove();

//Health regen
if (object_get_parent(object_index)==parent_main_character and global.attract==false and !instance_exists(obj_timetrial))
	{
		if healthregen=-1 and global.difficulty=DIFFICULTY.EXTRAEASY
			{
				healthregen=regenrate;
			}
		else if global.difficulty!=DIFFICULTY.EXTRAEASY
			{
				healthregen=-1;
			}

		//Health regeneration
		if healthregen!=-1 and hp!=scr_return_adjusted_hpmax()
			{
				healthregen=max(0,healthregen-1);
				if healthregen=0
					{
						healthregen=regenrate;
						hp+=1;
						scr_set_vibration(1,1,10);
						hp=clamp(hp,-1,hpmax);
						global.Edhealth=hp;
						var snd=audio_play_sound(sound_regen,0,0);
						audio_sound_gain(snd,global.sound_fx_volume*global.sound_fx_on,0);
						instance_create_layer(x+sprite_width*0.5-sprite_xoffset,y-32,"players",obj_healthup);
					}
			}
	}


//We won't move whilst transitioning between rooms
/*tURNED THIS OFF because it's causing problems
if (instance_exists(obj_transition)==true and object_get_parent(object_index)!=parent_main_character)
	{
		image_speed=0;
		exit;
	}*/
	
switch (state)
	{
		case PlayerState.idle:
			{
				scr_state_idle();
				break;
			}
		case PlayerState.running:
			{
				scr_state_running();
				break;
			}
		case PlayerState.air:
			{
				scr_state_air();
				break;
			}
		case PlayerState.onwall:
			{
				scr_state_onwall();
				break;
			}
		case PlayerState.wallclimb:
			{
				scr_state_wallclimb();
				break;
			}
		case PlayerState.lookup:
			{
				scr_state_lookup();
				break;
			}
		case PlayerState.duck:
			{
				scr_state_duck();
				break;
			}
		case PlayerState.pushing:
			{
				scr_state_push();
				break;
			}
		case PlayerState.cliffedge:
			{
				scr_state_cliff();
				break;
			}
		case PlayerState.ledgegrab:
			{
				scr_state_ledgehold();
				break;
			}
		case PlayerState.pulling:
			{
				scr_state_pull();
				break;
			}
		case PlayerState.ledgeclimb:
			{
				scr_state_ledgeclimb();
				break;
			}
		case PlayerState.spring:
			{
				scr_state_spring();
				break;
			}
		case PlayerState.teleport:
			{
				scr_state_teleport();
				break;
			}
		case PlayerState.debug:
			{
				var hinput=global.inputs[0];
				var vinput=global.inputs[1];
				if (canmove==false)
					{
						hinput=0;
						vinput=0;
					}

				if global.currentinstance!=self
					{
						hinput=0;
						vinput=0;
					}
				
				x+=hinput*10;
				y-=vinput*10;
				break;
			}
		case PlayerState.holding:
			{
				scr_state_holding();
				break;
			}
		case PlayerState.slideoffcliff:
			{
				scr_state_slideoffcliff();
				break;
			}
		case PlayerState.splat:
			{
				scr_state_splat();
				break;
			}
		case PlayerState.slidethroughgrate:
			{
				scr_state_slidethroughgrate();
				break;
			}
		case PlayerState.freeflying:
			{
				scr_state_freeflying();
				break;
			}
		case PlayerState.possessing:
			{
				scr_state_possessing();
				break;
			}
		case PlayerState.defeated:
			{
				scr_state_defeated();
				break;
			}
		case PlayerState.dead:	
			{
				scr_state_dead();
				break;
			}
		case PlayerState.dashing:
			{
				scr_state_dashing();
				break;
			}
		case PlayerState.petcat:
			{
				scr_state_petcat();
				break;
			}
		case PlayerState.carrying:
			{
				scr_state_carrying();
				break;
			}
		case PlayerState.beingcarried:
			{
				scr_state_beingcarried();
				break;
			}
		case PlayerState.digging:
			{
				scr_state_dig();
				break;
			}
		case PlayerState.caged:
			{
				scr_state_caged();
				break;
			}
		case PlayerState.bee:
			{
				scr_state_bee();
				break;
			}
		case PlayerState.GravityFlip:
			scr_state_gravflip();
			break;
	}
	
scr_state_anystate();

//Now set the xscale for fatmode lol
//image_xscale=image_xscale*(1+global.fatmode*5);

//Reset simulated input:
s_hinput=0;
s_vinput=0;
s_jump=0;
s_jumphold=false;
s_b_two=0; //Interact
s_b_three=0; //Sage possess
s_b_four=0; //Pulling

//Handle talking
//Wow that's much easier than the random bullshit I was doing before
if (hasdialogue==true and talking==true)
	{
		//Turn to face
		outlineshader=false;
		var currinst=global.currentinstance;
		var otherx=currinst.x;
		directionfacing=scr_sign_nonzero(otherx-x);
		state=PlayerState.idle;
		scr_dialoguemap_queue();
	}

//Now the help bar management
if global.currentinstance!=id
	{
		exit;
	}
	
//Also just check if there's someone to talk to
var cantalk=0;
if talkenabled=true
	{
		var nearest=scr_instance_nth_nearest(x,y,parent_possessable,1);
		if nearest=id
			{
				nearest=scr_instance_nth_nearest(x,y,parent_possessable,2);
			}
		if nearest!=noone
			{
				if distance_to_object(nearest)<global.talkdistance and !collision_line(x,y,nearest.x,nearest.y,obj_solid,0,1) and nearest.hasdialogue=1
					{
						cantalk=1;
						var name=nearest.name;
					}
			}
		//The only states talking is enabled
		if state!=PlayerState.idle and state!=PlayerState.running
			{
				cantalk=0;
			}
	}
	
//Check if there's an interactable object about
var interact;
var interactavailable=false;
for (var i=0; i<array_length_1d(interactable); i+=1)
	{
		if interactable[0]=noone
			{
				break;
			}
		//var interact=instance_place(x,y,interactable[i])
		var interact=collision_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom+1,interactable[i],false,true);
		if interact!=noone
			{
				interactavailable=true;
				break;
			}
	}

if global.helpbar=false
	{
		exit;
	}

scr_HUD_tips_clear();

switch(state)
	{
		case PlayerState.idle:
			{
				if jumpenabled=true
					{
						scr_HUD_set_tips_buttons(global.kb_b_one);
						scr_HUD_set_tips_text(scr_return_text(259));
					}
				//This has potential to cause some conflicts but worry about it when we get to it please
				if pullingenabled=true
					{
						if place_meeting(x+directionfacing,y,obj_solid)
							{
								scr_HUD_add_tips_buttons(global.kb_b_four);
								scr_HUD_add_tips_text(scr_return_text(263));
							}
					}
				if dashenabled=true and candash=true and dashcooldown=0
					{
						scr_HUD_add_tips_buttons(global.kb_b_four);
						scr_HUD_add_tips_text(scr_return_text(310));
					}
				if (gravityFlipEnabled)
					{
						scr_HUD_add_tips_buttons(global.kb_b_four);
						scr_HUD_add_tips_text(scr_return_text(634));
					}
				if digenabled=true
					{
						if position_meeting(x,bbox_bottom+1,obj_solid) or position_meeting(x,bbox_bottom+1,obj_semisolid)
							{
								scr_HUD_add_tips_buttons(global.kb_b_four);
								scr_HUD_add_tips_text(scr_return_text(370));
							}
					}
				if spinningenabled=true
					{
						if owner.state!=PlayerState.spinning
							{
								scr_HUD_add_tips_buttons(global.kb_b_two);
								scr_HUD_add_tips_text(scr_return_text(260));
							}
					}
				//Always disabled for people who can't talk
				if cantalk=1
					{
						scr_HUD_add_tips_buttons(global.kb_b_three);
						scr_HUD_add_tips_text(scr_return_text(261)+name);
					}
				if interactavailable=1
					{
						scr_HUD_add_tips_buttons(global.kb_b_two);
						scr_HUD_add_tips_text(interact.label);
					}
				if (cantalk=0 and usesageenabled==true)
					{
						scr_HUD_add_tips_buttons(global.kb_b_three);
						scr_HUD_add_tips_text(scr_return_text(262));
					}
				#region possession, very convoluted, please ignore forever
				if possessingenabled=true
					{
						var nearest=instance_nearest(x,y,parent_possessable);
						/*Why the fuck do I have this? No wonder the game lags horribly
						pathavailable=mp_grid_path(sage_grid,sage_path,x,y,x_target,y_target,true);
						if path_get_length(sage_path)>possessionrange
							{
								pathavailable=0;
							}

						if nearest.state=PlayerState.defeated or nearest.state=PlayerState.dead
							{
								pathavailable=0;
							}*/
						if pathavailable=1
							{
								if nearest.object_index=parent_main_character
									{
										scr_HUD_set_tips_buttons(global.kb_b_three);
										scr_HUD_set_tips_text(scr_return_text(269)+nearest.name);
									}
								else
									{
										scr_HUD_set_tips_buttons(global.kb_b_three);
										scr_HUD_set_tips_text(scr_return_text(270)+nearest.name);
									}
							}
						else
							{
								scr_HUD_tips_clear();
							}
						scr_HUD_add_tips_buttons(global.kb_b_two);
						var nearest=instance_nearest(round(x),round(y),parent_main_character);
						var _name=nearest.name;
						scr_HUD_add_tips_text(scr_return_text(271)+_name);
						scr_HUD_add_tips_text(scr_return_text(271)+parent_main_character.name);
					}
					#endregion
				break;
			}
		case PlayerState.running:
			{
				if jumpenabled=true
					{
						scr_HUD_set_tips_buttons(global.kb_b_one);
						scr_HUD_set_tips_text(scr_return_text(259));
					}
				if spinningenabled=true
					{
						if owner.state!=PlayerState.spinning
							{
								scr_HUD_add_tips_buttons(global.kb_b_two);
								scr_HUD_add_tips_text(scr_return_text(260));
							}
					}
				if dashenabled=true and candash=true and dashcooldown=0
					{
						scr_HUD_add_tips_buttons(global.kb_b_four);
						scr_HUD_add_tips_text(scr_return_text(310));
					}
				if digenabled=true
					{
						if position_meeting(x,bbox_bottom+1,obj_solid) or position_meeting(x,bbox_bottom+1,obj_semisolid)
							{
								scr_HUD_add_tips_buttons(global.kb_b_four);
								scr_HUD_add_tips_text(scr_return_text(370));
							}
					}
				if cantalk=1
					{
						scr_HUD_add_tips_buttons(global.kb_b_three);
						scr_HUD_add_tips_text(scr_return_text(261)+name);
					}
				if interactavailable=1
					{
						scr_HUD_add_tips_buttons(global.kb_b_two);
						scr_HUD_add_tips_text(interact.label);
					}
				if (cantalk==false and usesageenabled==true)
					{
						scr_HUD_add_tips_buttons(global.kb_b_three);
						scr_HUD_add_tips_text(scr_return_text(262));
					}
				break;
			}
		case PlayerState.air:
			{
				if spinningenabled=true
					{
						if owner.state!=PlayerState.spinning
							{
								scr_HUD_add_tips_buttons(global.kb_b_two);
								scr_HUD_add_tips_text(scr_return_text(260));
							}
					}
				if dashenabled=true and candash=true and dashcooldown=0
					{
						scr_HUD_add_tips_buttons(global.kb_b_four);
						scr_HUD_add_tips_text(scr_return_text(310));
					}
				if birdmodeenabled=true
					{
						scr_HUD_add_tips_buttons(global.kb_b_one);
						scr_HUD_add_tips_text(scr_return_text(352));
						//Carrying
						if carrytarget!=noone
							{
								scr_HUD_add_tips_buttons(global.kb_b_four);
								scr_HUD_add_tips_text(scr_return_text(357));
							}
					}
				if (usesageenabled==true)
					{
						scr_HUD_add_tips_buttons(global.kb_b_three);
						scr_HUD_add_tips_text(scr_return_text(262));
					}
				break;
			}
		case PlayerState.lookup:
			{
				if jumpenabled=true
					{
						scr_HUD_set_tips_buttons(global.kb_b_one)
						scr_HUD_set_tips_text(scr_return_text(259));
					}
				if (usesageenabled==true)
					{
						scr_HUD_add_tips_buttons(global.kb_b_three);
						scr_HUD_add_tips_text(scr_return_text(262));
					}
				break;
			}
		case PlayerState.duck:
			{
				if jumpenabled=true
					{
						scr_HUD_set_tips_buttons(global.kb_b_one)
						scr_HUD_set_tips_text(scr_return_text(259));
					}
				if (usesageenabled==true)
					{
						scr_HUD_add_tips_buttons(global.kb_b_three);
						scr_HUD_add_tips_text(scr_return_text(262));
					}
				break;
			}
		case PlayerState.pushing:
			{	
				if jumpenabled=true
					{
						scr_HUD_set_tips_buttons(global.kb_b_one)
						scr_HUD_set_tips_text(scr_return_text(259));
					}
				if pullingenabled=true
					{
						scr_HUD_add_tips_buttons(global.kb_b_four);
						scr_HUD_add_tips_text(scr_return_text(263));
					}
				if (usesageenabled==true)
					{
						scr_HUD_add_tips_buttons(global.kb_b_three);
						scr_HUD_add_tips_text(scr_return_text(262));
					}
				break;
			}
		case PlayerState.cliffedge:
			{
				if jumpenabled=true
					{
						scr_HUD_set_tips_buttons(global.kb_b_one)
						scr_HUD_set_tips_text(scr_return_text(259));
					}
				if (usesageenabled==true)
					{
						scr_HUD_add_tips_buttons(global.kb_b_three);
						scr_HUD_add_tips_text(scr_return_text(262));
					}
				break;
			}
		case PlayerState.ledgegrab:
			{
				if jumpenabled=true
					{
						scr_HUD_set_tips_buttons(global.kb_b_one)
						scr_HUD_set_tips_text(scr_return_text(259));
					}
				var button=(gravMultiplier==1)	?	global.kb_down	:	global.kb_up;
				scr_HUD_add_tips_buttons(button);
				scr_HUD_add_tips_text(scr_return_text(264));
				if ledgeclimbenabled=true
					{
						var xtemp=x+14*directionfacing;
						var ytemp=y-32*gravMultiplier;
						if !place_meeting(xtemp,ytemp,obj_solid) and sprite_index=sprite_ledgehold
							{
								var button=(gravMultiplier==1)	?	global.kb_up	:	global.kb_down;
								scr_HUD_add_tips_buttons(button);
								scr_HUD_add_tips_text(scr_return_text(265));
							}
					}
				if (usesageenabled==true)
					{
						scr_HUD_add_tips_buttons(global.kb_b_three);
						scr_HUD_add_tips_text(scr_return_text(262));
					}
				break;
			}
		case PlayerState.pulling:
			{
				if jumpenabled=true
					{
						scr_HUD_set_tips_buttons(global.kb_b_one)
						scr_HUD_set_tips_text(scr_return_text(259));
					}
				if (usesageenabled==true)
					{
						scr_HUD_add_tips_buttons(global.kb_b_three);
						scr_HUD_add_tips_text(scr_return_text(262));
					}
				break;
			}
		case PlayerState.ledgeclimb:
			{
				if (usesageenabled==true)
					{
						scr_HUD_add_tips_buttons(global.kb_b_three);
						scr_HUD_add_tips_text(scr_return_text(262));
					}
				break;
			}
		case PlayerState.teleport:
			{
				scr_HUD_tips_clear();
				break;
			}
		case PlayerState.slidethroughgrate:
			{
				scr_HUD_tips_clear();
				break;
			}
		case PlayerState.possessing:
			{
				scr_HUD_set_tips_buttons(global.kb_b_three);
				scr_HUD_set_tips_text(scr_return_text(266));
				break;
			}
		case PlayerState.freeflying:
			{
				if explodeenabled=true
					{
						scr_HUD_set_tips_buttons(global.kb_b_two);
						if reversewhendefeatedenabled=true
							{
								scr_HUD_set_tips_text(scr_return_text(311));
							}
						else
							{
								scr_HUD_set_tips_text(scr_return_text(267));
							}
						if (usesageenabled==true)
							{
								scr_HUD_add_tips_buttons(global.kb_b_three);
								scr_HUD_add_tips_text(scr_return_text(262));
							}
					}
				#region possession, very convoluted and stupid, please ignore
				if possessingenabled=true
					{
						var nearest=instance_nearest(x,y,parent_possessable);
						/*var x_target=nearest.x;
						var y_target=nearest.y;
						pathavailable=mp_grid_path(sage_grid,sage_path,x,y,x_target,y_target,true);
						if path_get_length(sage_path)>possessionrange
							{
								pathavailable=0;
							}

						if nearest.state=PlayerState.defeated or nearest.state=PlayerState.dead
							{
								pathavailable=0;
							}*/
						if pathavailable=1
							{
								if nearest.object_index=parent_main_character
									{
										scr_HUD_set_tips_buttons(global.kb_b_three);
										scr_HUD_set_tips_text(scr_return_text(269)+nearest.name);
									}
								else
									{
										scr_HUD_set_tips_buttons(global.kb_b_three);
										scr_HUD_set_tips_text(scr_return_text(270)+nearest.name);
									}
							}
						else
							{
								scr_HUD_tips_clear();
							}
						scr_HUD_add_tips_buttons(global.kb_b_two);
						var nearest=instance_nearest(round(x),round(y),parent_main_character);
						var _name=nearest.name;
						scr_HUD_add_tips_text(scr_return_text(271)+_name);
					}
				#endregion
				break;
			}
		case PlayerState.onwall:
			{
				scr_HUD_tips_clear();
				if jumpenabled=true
					{
						scr_HUD_set_tips_buttons(global.kb_b_one)
						scr_HUD_set_tips_text(scr_return_text(259));
					}
				if wallclimbenabled=true and !place_meeting(x,y-gravMultiplier,obj_solid)
					{
						scr_HUD_add_tips_buttons(global.kb_up);
						scr_HUD_add_tips_text(scr_return_text(268));
					}
				if (usesageenabled==true)
					{
						scr_HUD_add_tips_buttons(global.kb_b_three);
						scr_HUD_add_tips_text(scr_return_text(262));
					}
				break;
			}
		case PlayerState.wallclimb:
			{
				scr_HUD_tips_clear();
				if jumpenabled=true
					{
						scr_HUD_set_tips_buttons(global.kb_b_one)
						scr_HUD_set_tips_text(scr_return_text(259));
					}
				if (usesageenabled==true)
					{
						scr_HUD_add_tips_buttons(global.kb_b_three);
						scr_HUD_add_tips_text(scr_return_text(262));
					}
				break;
			}
		case PlayerState.carrying:
			{
				scr_HUD_tips_clear();
				scr_HUD_set_tips_buttons(global.kb_b_one);
				scr_HUD_set_tips_text(scr_return_text(352));
				//Carrying
				scr_HUD_add_tips_buttons(global.kb_b_four);
				if carrying=noone
					{
						scr_HUD_add_tips_text(scr_return_text(266));
					}
				else
					{
						scr_HUD_add_tips_text(scr_return_text(358));
					}
				if (usesageenabled==true)
					{
						scr_HUD_add_tips_buttons(global.kb_b_three);
						scr_HUD_add_tips_text(scr_return_text(262));
					}
				break;
			}
		case PlayerState.bee:
			{
				scr_HUD_tips_clear();
				scr_HUD_set_tips_buttons(global.kb_b_one);
				scr_HUD_set_tips_text(scr_return_text(352));
				if (shootingenabled==true)
					{
						if (guncooldown==0)
							{
								scr_HUD_add_tips_buttons(global.kb_b_four);
								scr_HUD_add_tips_text(scr_return_text(417));
							}
					}
				if (usesageenabled==true)
					{
						scr_HUD_add_tips_buttons(global.kb_b_three);
						scr_HUD_add_tips_text(scr_return_text(262));
					}
				break;
			}
		default:
			{
				if (usesageenabled==true)
					{
						scr_HUD_add_tips_buttons(global.kb_b_three);
						scr_HUD_add_tips_text(scr_return_text(262));
					}
				break;
			}
	}