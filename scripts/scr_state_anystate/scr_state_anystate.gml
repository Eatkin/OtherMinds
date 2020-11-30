//Created 06/10/19
//Last updated 06/10/19


var hinput=global.inputs[0];
var b_two=global.inputs[5];
var b_three=global.inputs[6];
var b_four=global.inputs[7];

if canmove=0
	{
		b_two=s_b_two;
		b_three=s_b_three;
		b_four=s_b_four;
		hinput=s_hinput;
	}
	
var gravMultiplier=dsin(global.gravdirection);

//Let's deal with Sage's stuff first
//This computes a path to the target and goes to possessing state if close enough
if possessingenabled=true
	{
		if b_three=1 and canpossess=1
			{
				var nearest=instance_nearest(x,y,parent_possessable);
				if pathavailable=1
					{
						target=nearest;
						if nearest.state!=PlayerState.defeated and nearest.state!=PlayerState.dead
							{
								state=PlayerState.possessing;
								canpossess=0;
								path_speed=0;
								exit;
							}
					}
			}
	
		//This stops re-triggering possession as soon as you cancel possession
		if canpossess=0 and state!=PlayerState.possessing
			{
				canpossess=1;
			}
	}

//We lock direction for ledgegrab state and other states
//Not really sure how to best do this but one huge line of statements sure looks hella ugly
if hinput!=0 and state!=PlayerState.ledgegrab and state!=PlayerState.ledgeclimb and state!=PlayerState.pulling and state!=PlayerState.duck and state!=PlayerState.lookup and state!=PlayerState.teleport and state!=PlayerState.holding and state!=PlayerState.slideoffcliff and state!=PlayerState.defeated and state!=PlayerState.onwall and state!=PlayerState.wallclimb and state!=PlayerState.dashing and state!=PlayerState.dead and state!=PlayerState.petcat
	{
		directionfacing=scr_sign_nonzero(hinput);
	}
	
//Change image whatever based on direction facing
if manualscalingenabled=false
	{
		image_xscale=sign(directionfacing)*scaleoverride;
		if (global.moonwalk==true)
			{
				image_xscale=-image_xscale;
			}
	}

//Here's the override option
if xscaleflipenabled=false and manualscalingenabled=false
	{
		image_xscale=scaleoverride;
		if (global.moonwalk==true)
			{
				image_xscale=-image_xscale;
			}
	}
	

	
//Airspriteflipenabled sets yscale to the direction of yspeed
//Otherwise it's the same as gravity multiplier
if (airspriteflipenabled)
	if (state==PlayerState.air)
		image_yscale=scr_sign_nonzero(image_yscale)*scaleoverride;	//It is -1 for negative yspeed and 1 for all other values
	else
		image_yscale=scaleoverride*gravMultiplier;
else
	image_yscale=gravMultiplier;
	
//Masks
if (airmaskenabled)
	if (state==PlayerState.air or state==PlayerState.carrying)
		mask_index=maskair;
	else
		mask_index=masknormal;
		
if (wallmaskenabled)
	if state=PlayerState.wallclimb or state=PlayerState.onwall or state=PlayerState.ledgegrab
		mask_index=maskwall;
	else
		mask_index=masknormal;

//Now handle the state stuff
//We just reset the time in state timer
if state!=previousstate
	{
		timeinstate=-1;
	}
	
previousstate=state;
timeinstate+=1;
	
//Cancel the felloffcliff state
//This has to go before the check for falling off a cliff
if state!=PlayerState.defeated and (timeinstate>30 or hinput==0)
	{
		felloffcliff=0;
	}
	
//Update some stuff like coyote time and jump buffer
coyotetime-=1;
jumpbuffertime-=1;

//Also update the last 'safe' location
//Make sure we're in a safe state!
if (place_meeting(x,y+gravMultiplier,obj_solid) and state!=PlayerState.slideoffcliff)
	{
		if (gravMultiplier==1)
			{
				xsafe=xprevious;
				ysafe=yprevious;
			}
		else
			{
				xsafeInvert=xprevious;
				ysafeInvert=yprevious;
			}
	}
	
//Reset can dash
if place_meeting(x,y+gravMultiplier,obj_solid)
	{
		candash=true;
	}
if place_meeting(x,y+gravMultiplier,obj_semisolid) and !place_meeting(x,y,obj_semisolid)
	{
		candash=true;
	}

if candash=true
	{
		dashcooldown=max(0,dashcooldown-1);
	}
	
//Update the marker timer
markertimer-=1;
if markertimer=0
	{
		marker_index=marker_index^1;
		markertimer=4;
	}
	
var gethurt=0;
//Check we haven't fallen off the screen or hit some spikes
var fallenOffScreen=false;
if ((gravMultiplier==1 and y>room_height) or (gravMultiplier==-1 and y<0))
	fallenOffScreen=true;
	
if (fallenOffScreen)
	{
		felloffcliff=true;
		//We just die if we are not the current player because the espawining is kind of weird
		//EXCEPT we respawn NPCs
		if hp>0 and (global.currentinstance=id or object_get_parent(object_index)!=parent_enemy)
			{
				if (gravMultiplier==1)
					{
						x=xsafe;
						y=ysafe;
					}
				else
					{
						x=xsafeInvert;
						y=ysafeInvert;
					}
				scr_snap_to_floor();
				xspeed=0;
				yspeed=0;
				gethurt=1;
				state=PlayerState.idle;
			}
		else if state!=PlayerState.dead
			{
				if (global.currentinstance==id and object_get_parent(object_index)!=parent_main_character)
					{
						var spawnY=(gravMultiplier==1) ? room_height-sprite_get_height(spr_Sage) : sprite_get_height(spr_Sage);
						scr_spawn_Sage(x,spawnY);
					}
				state=PlayerState.defeated;
			}
	}

//Cycle through harmful object
if iframes=0
	{
		var i;
		for (i=0;i<array_length_1d(harmful); i+=1)
			{
				if place_meeting(x,y,harmful[i])
					{
						#region exceptions
						//I have to do these first because otherwise it may overwrite getting hurt and make Ed invulnerable
						//That happened. Trust me. Thanks, Me.
						if (harmful[i]==obj_boss_laser)
							{
								
								var laser=instance_place(x,y,harmful[i]);
								if laser.state=BARRIER.NORMAL
									{
										gethurt=1;
									}
							}
						#endregion exceptions
						else
							{
								gethurt=1;
								break;
							}
					}
			}
	}

	
if (gethurt==true)
	scr_get_hurt();
	
//Set iframes
iframes=max(iframes-1,0);

//Get hurt by enemies
//(Optionally insert enemiesattackenabled==true here, but it stops you getting hurt UNLESS enemies attack you)
//Okay I found out why I had that condition, enemies hurt each other on contact without it
//Anyway fixed
var canbehurt=true;
if (object_is_ancestor(object_index,parent_enemy)==true and enemiesattackenabled==false)
	{
		canbehurt=false;
	}
if (canbehurt==true and canbehurtenabled==true and state!=PlayerState.defeated and state!=PlayerState.dead)
	{
		var enemy=instance_place(x,y,parent_enemy);
		if enemy!=noone and iframes=0 and enemy.canhurtenabled=true
			{
				if enemy.state!=PlayerState.defeated and enemy.state!=PlayerState.dead and enemy.iframes!=60
					{
						iframes=60;
						if global.currentinstance=id
							{
								instance_create_layer(x+sprite_width/2-sprite_xoffset,y-16*gravMultiplier,"Players",obj_brokenheart);
								scr_play_sound(sound_hurt,0,0);
								scr_set_vibration(1,1,10);
							}
						if object_get_parent(object_index)=parent_main_character
							{
								global.Edhealth-=1;
							}
						hp-=1;
					}
			}
	}

if hp<0 and state!=PlayerState.defeated and state!=PlayerState.dead
	{
		if state=PlayerState.carrying
			{
				if carrying!=noone
					{
						carrying.state=PlayerState.idle;
						if carrying.object_index!=parent_push
							{
								carrying.layer=carryingdepth;
							}
					}
				carrying=noone;	
			}
		state=PlayerState.defeated;
		exit;
	}
	
//Now handle talking to people
var nearest=noone;
if talkenabled=true
	{
		var nearest=scr_instance_nth_nearest(x,y,parent_possessable,1);
		if nearest=id
			{
				nearest=scr_instance_nth_nearest(x,y,parent_possessable,2);
			}
		if state!=PlayerState.idle and state!=PlayerState.running
			{
				nearest=noone;
			}
		if nearest!=noone
			{
				//Make sure we can only talk in certain states
				if nearest.state=PlayerState.idle or nearest.state=PlayerState.running
					{
						if b_three=1 and distance_to_object(nearest)<global.talkdistance and nearest.hasdialogue=1
							{
								//exit if there's something in the way
								if collision_line(x,y,nearest.x,nearest.y,obj_solid,0,1)
									{
										exit;
									}
								if nearest.hasdialogue=1 and nearest.talking=0
									{
										nearest.talking=1;
									}
							}
					}
			}
		else
			{
				//The speechbubble doesn't do its own checks properly so we'll override it here
				obj_speechbubble.visible=false;
			}
	}
	
//Check iframes so we can reset waiting timer
if iframes>0 and waiting=true
	{
		waiting=false;
		timeinstate=0;
	}
	

//Create Sage but not if we're in some certain states because you'll softlock yourself you idiot
//Also not if we're talking
var spawnsage=0;
if (usesageenabled==true and b_three=1 and state!=PlayerState.teleport and state!=PlayerState.slidethroughgrate and state!=PlayerState.digging)
	{
		if nearest!=noone
			{
				if nearest.talking=0
					{
						spawnsage=1;
					}
			}
		else
			{
				spawnsage=1;
			}
		if spawnsage=1 and possessingenabled=false
			{
				//This was for smashers (like Thwomps) but they're way too buggy so scrapped them
				if smasherenabled=true
					{
						var _xoffset=sprite_get_width(spr_Sage)*0.5;
						var side=scr_sign_nonzero(parent_main_character.x-x);
						var _x=bbox_left-_xoffset;
						if side=1
							{
								_x=bbox_right+_xoffset;
							}
						scr_spawn_Sage(_x,y);
					}
				else
					{
						scr_spawn_Sage();
					}
			}
	}
if b_three and (state=PlayerState.teleport or state=PlayerState.slidethroughgrate)
	{
		scr_play_sound(snd_sage_nope,false,0);
	}
	
//Interact!
//I had this in two seperate scripts before what the fuck is wrong with me
//General code for interactive objects
if (global.currentinstance==id and (state==PlayerState.idle or state==PlayerState.running))
	{
		for (var i=0; i<array_length_1d(interactable); i+=1)
			{
				if (interactable[0]==noone)
					{
						break;
					}
				//var interact=instance_place(x,y,interactable[i]);
				var interact=collision_rectangle(bbox_left,bbox_top-1,bbox_right,bbox_bottom+1,interactable[i],false,true);
				if (interact!=noone)
					{
						if (!interact.active)
							interact.outlineshader=true;
						if (b_two)
							{
								interact.active=1;
								if (interactable[i]==obj_grate)
									interact.user=id;
							}
					}
			}
	}
	

if interactwithblocksenabled=true
	{
		//Let's now push the player out of boundary intersection
		//The moving platforms can mess with this
		while (x<0)
			{
				x+=1;
			}
		while (x>room_width)
			{
				x-=1;
			}

	}
	
//Collect an orb
if collectitemsenabled=true
	{
		var orb=instance_place(x,y,parent_orb)
		if orb!=noone
			{
				orb.collected=1;
			}
	}
	
//Turn off blinking and idle animation if not idle
if state!=PlayerState.idle
	{
		blinking=0;
		waiting=0;
	}
	
if isasignenabled=true and spinningenabled=true
	{
		if b_two=1 and owner.state!=PlayerState.spinning
			{
				with (owner)
					{
						//Set the correct image_index or we can't spin when moving right
						image_index=round((image_index+1)/11)*11;
						active=1;
					}
			}
	}

if explodeenabled=true and b_two=1
	{
		if reversewhendefeatedenabled=true
			{
				state=PlayerState.defeated;
			}
		else
			{
				var emitter=instance_create_layer(x,y,"controllers",obj_sound_emitter);
				emitter.soundid=sound_explode;
				instance_destroy();
			}
	}