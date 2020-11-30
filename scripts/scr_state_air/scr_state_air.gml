//Created 05/10/19
//Last updated 05/10/19

var jumpinput=global.inputs[4];
var holdingjumpinput=global.inputs[16];
var hinput=global.inputs[0];
var vinput=global.inputs[1];
var b_four=global.inputs[7];

if canmove=0
	{
		jumpinput=s_jump;
		holdingjumpinput=s_jumphold;
		hinput=s_hinput;
		vinput=s_vinput;
		b_four=s_b_four;
	}
	

//Moving up and down, left and right etc. Handles bonking head, landing on the floor.
//Includes jump buffering, takes coyote time into account

//First handle jumping if possible
if (jumpinput and jumpenabled)
	{
		if (coyotetime>0)
			{
				scr_jump();
				coyotetime=0;
			}
		else
			{
				//We'll use this jump buffer for when you touch the ground
				jumpbuffertime=jumpbuffertimemax;
			}
		if (birdmodeenabled)
			{
				yspeed+=jumpheight;
				yspeed=max(-3,yspeed); //Cap
			}
	}

var gravMultiplier=dsin(global.gravdirection);
//Now check if we're holding jump
//I don't know why this is outside the gravity enabled check but uhhh I don't dare touch it incase everything explodes
if (holdingjumpinput and jumpenabled and !birdmodeenabled)
    {
        yspeed-=global.gravstrength*.25*gravMultiplier;
    }

//Now lets apply gravity and also make sure we aren't going too fast
if (gravityenabled)
	{
		//Bird mode means rate of descent is related to xspeed
		if (birdmodeenabled)
			{
				var _g=global.gravstrength*0.1;
				//This stops the weird looking sudden switch between yspeed=1 to yspeed=-1
				if (yspeed==clamp(yspeed,0,1) and !holdingjumpinput)
					{
						_g*=3;
					}
				if (vinput>0 and yspeed>=0)
					{
						yspeed=lerp(yspeed,(1-vinput)*_g,0.2);
						if (abs(yspeed)<0.1)
							{
								yspeed=0;
							}
					}
				else if (vinput<0)
					{
						yspeed+=_g*(1+abs(vinput));
					}
				else
					{
						yspeed+=_g;
					}
				/*else
					{
						//This linked acceleration due to gravity with xspeed which was a cool idea but its dumb
						yspeed+=0.5*global.gravstrength*((maxxspeed-abs(xspeed))/maxxspeed);
					}*/
				if (yspeed>0)
					{
						yspeed=clamp(yspeed,0,maxyspeed);
					}
			}
		else
			{
				yspeed+=global.gravstrength*gravMultiplier;
				//Uhh don't know why I need this but you "moon jump" without it
				//THIS ACTUALLY BREAKS SPRINGS NOW!!!
				
				if (sign(yspeed)==gravMultiplier)
					yspeed=scr_clampGeneral(yspeed,0,maxyspeed*gravMultiplier);
				/*else if (sign(yspeed)=-gravMultiplier)
					yspeed=scr_clampGeneral(yspeed,gravMultiplier*jumpheight,0);*/
				//If we're not holding jump and early in the state, increase the rate of speed decrease
				if (yspeed<0 and timeinstate<15 and !holdingjumpinput)
					{
						yspeed+=global.gravstrength*0.5*gravMultiplier;
					}
			}
	}

//Had a bit of a problem with falling through semi-solids so here's a quick fix (hopefully)
var maxmovement=2;
if (sign(yspeed)>=0 and place_meeting(x,y,obj_semisolid) and gravMultiplier==1)
	for (var i=1; i<=maxmovement; i+=1)
		if (!place_meeting(x,y-i*gravMultiplier,obj_semisolid) and !place_meeting(x,y-i*gravMultiplier,obj_solid))
			{
				y-=i*gravMultiplier;
				break;
			}
	
//Now we can apply left and right movement
if (hinput!=0)
	//add acceleration but make sure we don't exceed max speed
	//Note i use a modified version so we slow down faster in the air
	if (smoothaccelerationenabled)
		scr_add_xacceleration_smooth(1.5*hinput);
	else
		scr_add_xacceleration_linear(1.5*hinput);
else if (decelerationenabled)
	//Reduce speed - stop if we get to slow
	if (smoothaccelerationenabled)
		scr_subtract_xacceleration_smooth();
	else
		scr_subtract_xacceleration_linear();

//Now we can move horizontally, followed by moving vertically
scr_xmove_loop(hinput);
	
var xtemp;
if (directionfacing=1)
	xtemp=bbox_right+directionfacing;
else
	xtemp=bbox_left+directionfacing;
	
var springcollide=0;
var enemycollide=0;
var edcollide=0;
var repeats=abs(yspeed);
if (birdmodeenabled)
	repeats=floor(repeats);
else
	repeats=ceil(repeats);


//Here we remove the fractional part of y
//Also what the fuck lol
var yy;
if (yspeed>=0)
	yy=floor(y);
else
	yy=ceil(y);
var yfrac=yy-y;
y=yy;

repeat(repeats)
	{
		//If we're a flying bird and we fly too high, break the loop
		if (birdmodeenabled)
			{
				if (y<-120 and yspeed<0)
					{
						yspeed=max(yspeed,0);
						continue;
					}
			}
		if (springsenabled and sign(yspeed)==gravMultiplier)
			{
				if (place_meeting(x,y+sign(yspeed),obj_spring))
					{
						springcollide=1;
						break;
					}
			}
		if (jumpattackenabled)
			{
				var enemy=scr_jumpattack_find_enemy();
				/*if enemy=id
					{
						enemy=noone;
					}*/
				//Sorry rather a long list of conditions because this halts the downward movement otherwise
				if (enemy!=noone and (sign(yspeed)==gravMultiplier or yspeed==0) and enemy.state!=PlayerState.defeated and enemy.state!=PlayerState.dead)
					{
						enemycollide=1;
						break;
					}
				if (jumponedenabled and sign(yspeed)==gravMultiplier)
					{
						var player=instance_place(x,y+1,parent_main_character);
						if (player!=noone and (sign(yspeed)==gravMultiplier or yspeed=0) and iframes=0 and player.state!=PlayerState.defeated and player.state!=PlayerState.dead and player.iframes<=0)
							{
								edcollide=1;
								break;
							}
					}
			}
		#region splat (don't look at this its horrible)
		if (splatenabled and timeinstate>20*maxxspeed)
			{
				if (!place_meeting(x,y+sign(yspeed),obj_solid) and !place_meeting(x,y+sign(yspeed),obj_semisolid))
					y+=sign(yspeed);
				//This means the player is IN a semisolid, not ON one
				else if (place_meeting(x,y+sign(yspeed),obj_semisolid) and place_meeting(x,y,obj_semisolid))
					y+=sign(yspeed);
				else if (place_meeting(x,y+sign(yspeed),obj_solid) and sign(yspeed)=-gravMultiplier and interactwithblocksenabled)
					{
						yspeed=0;
						break;
					}
				else if (place_meeting(x,y+sign(yspeed),obj_semisolid) and sign(yspeed)==1 and interactwithblocksenabled)
					{
						yspeed=0;
						state=PlayerState.splat;
						sprite_index=sprite_splat;
						image_index=0;
						xspeed=0;
						scr_play_sound(sound_splat,0,0);
						if global.currentinstance=id
							{
								scr_set_vibration(1,1,10);
							}
						exit;
					}
				else if (place_meeting(x,y+sign(yspeed),obj_solid) and sign(yspeed)==gravMultiplier and interactwithblocksenabled)
					{
						yspeed=0;
						state=PlayerState.splat;
						sprite_index=sprite_splat;
						image_index=0;
						xspeed=0;
						scr_play_sound(sound_splat,0,0);
						if global.currentinstance=id
							{
								scr_set_vibration(1,1,10);
							}
						exit;
					}
			}
		#endregion
		else
			{
				if (sign(yspeed)!=-1)
					{
						var semisolid=instance_place(x,y+gravMultiplier,obj_semisolid);
						if (semisolid!=noone)
							{
								if (scr_inaircheck()==false)
									{
										yspeed=0;
										state=PlayerState.idle;
										break;
									}
							}
					}
				if (!place_meeting(x,y+sign(yspeed),obj_solid) or !interactwithblocksenabled)
					{
						y+=sign(yspeed);
					}
				else
					{
						//yspeed=0;
						//Specific case here if we've buffered a jump
						if (jumpbuffertime>0 and jumpenabled and (place_meeting(x,y+gravMultiplier,obj_solid) or (place_meeting(x,y+gravMultiplier,obj_semisolid) and gravMultiplier==1)))
							{
								scr_jump();
								exit;
							}
						//We will try and move around blocks
						if (sign(yspeed)==-gravMultiplier)
							{
								//I also limit how much we can do this to half a sprite width
								var free_dir=0;
								var freePos=(gravMultiplier==1) ? bbox_top-1 : bbox_bottom+1;
								if (!position_meeting(bbox_right,freePos,obj_solid) and !position_meeting(x,freePos,obj_solid))
									free_dir=1;
								if (!position_meeting(bbox_left,freePos,obj_solid) and !position_meeting(x,freePos,obj_solid))
									free_dir=-1;
								if (free_dir==0)
									{
										yspeed=0;
										break;
									}
								var bboxwidth=abs(bbox_right-bbox_left)+1;
								for (var i=0; i<bboxwidth; i+=1)
									{
										if (!place_meeting(x+free_dir,y,obj_solid))
											x+=free_dir;
										else
											break;
										if (!place_meeting(x,y-gravMultiplier,obj_solid))
											break;
									}
							}
						else
							{
								yspeed=0;
								break;
							}
					}
			}
			
		
		//Okay now let's also do the ledge grab
		if ((sign(yspeed)==gravMultiplier or yspeed==0) and ledgegrabenabled)
			{
				if (wallmaskenabled)
					{
						mask_index=maskwall;
					}
				for (var i=0; i<3; i+=1)
					{
						var bboxCheck=(gravMultiplier==1) ? bbox_top : bbox_bottom;
						if (instance_position(xtemp+i,bboxCheck,obj_solid) and !instance_position(xtemp+i,bboxCheck-gravMultiplier,obj_solid) and !place_meeting(x,y+gravMultiplier,obj_solid)  and !place_meeting(x,y,obj_solid))
							{
								x+=i
								state=PlayerState.ledgegrab;
								yspeed=0;
								//Minor annoyance, if you press jump on the first frame you grab a ledge it doesn't work - this fixes that issue
								if (jumpinput)
									{
										yspeed=jumpheight*gravMultiplier;
										state=PlayerState.air;
										y-=gravMultiplier;
										scr_play_sound(sound_jump,0,0);
									}
								else
									exit;
							}
					}
				if (airmaskenabled)
					mask_index=maskair;
				else
					mask_index=masknormal;
			}
		//Finally collect an orb
		//This is a fail safe because you can 'phase through' an orb
		if (collectitemsenabled)
			{
				var orb=instance_place(x,y,parent_orb)
				if (orb!=noone)
					orb.collected=true;
			}
	}
	
//Failsafes
if (springsenabled and (sign(yspeed)==gravMultiplier or yspeed=0))
	{
		if place_meeting(x,y+sign(yspeed),obj_spring)
			springcollide=true;
		if (springcollide)
			{
				var spring=instance_place(x,y+sign(yspeed),obj_spring);
				spring.springing=true;
				spring=image_index=0; //Reset image_index - this is probably pointless but its a bug catcher
				state=PlayerState.spring;
				image_index=0;
				image_speed=1;
				sprite_index=sprite_spring;
				exit;
			}
	}
	
if (jumpattackenabled and sign(yspeed)==gravMultiplier)
	{
		var enemy=scr_jumpattack_find_enemy();
		/*if enemy=id
			{
				enemy=noone;
			}*/
		if (enemy!=noone and (sign(yspeed)==gravMultiplier or yspeed==0))
			enemycollide=true;
		if (jumponedenabled and iframes==0 and sign(yspeed)==gravMultiplier)
			{
				var player=instance_place(x,y+gravMultiplier,parent_main_character);
				if (player!=noone and (sign(yspeed)==gravMultiplier or yspeed==0))
					edcollide=true;
			}
	}
	
if (enemycollide)
	{
		if (enemy.state!=PlayerState.defeated and enemy.state!=PlayerState.dead)
			{
				if (enemy.canbehurtenabled)
					{
						with (enemy)
							{
								if (hp!=HP.INF)
									{
										hp-=1;
										iframes=60;
									}
								if (hp<0)
									state=PlayerState.defeated;
								yspeed=0;
							}
					}
				yspeed=jumpheight*gravMultiplier;
				
				//Move away from being hit by them
				while (place_meeting(x,y,enemy))
					if (!place_meeting(x,y-gravMultiplier,obj_solid))
						y-=gravMultiplier;
					else
						break;
					
				//Effects and shit
				scr_play_sound(sound_jumponenemy,0,0);
				var smokeBbox=(gravMultiplier==1) ? enemy.bbox_top : enemy.bbox_bottom;
				instance_create_layer(enemy.x,smokeBbox,"Players",obj_smoke_small);
				if (global.currentinstance==id)
					scr_set_vibration(1,1,10);
			}
	}

if (edcollide)
	{
		if (player.state!=PlayerState.defeated and player.state!=PlayerState.dead and player.iframes<=0)
			{
				if (player.canbehurtenabled)
					with (player)
						{
							hp-=1;
							iframes=60;
							if (hp<0)
								{
									state=PlayerState.defeated;
								}
						}
						
				yspeed=jumpheight*gravMultiplier;
				scr_play_sound(sound_jumponenemy,0,0);
				var smokeBbox=(gravMultiplier==1) ? player.bbox_top : player.bbox_bottom;
				instance_create_layer(player.x,smokeBbox,"Players",obj_smoke_small);
				if (global.currentinstance==id)
					scr_set_vibration(1,1,10);
			}
	}

if (hinput!=0 and sign(yspeed)==gravMultiplier and walljumpenabled)
	{
		if (wallmaskenabled)
			mask_index=maskwall;
			
		//This checks we're against a wall, we're not on the floor and we're not too high to grab a wall
		var bboxCheck=(gravMultiplier==1) ? bbox_top : bbox_bottom;
		if (place_meeting(x+sign(hinput),y,obj_solid) and !place_meeting(x,y+gravMultiplier,obj_solid) and !place_meeting(x,y,obj_solid) and position_meeting(x+image_xscale*sprite_width*0.5*sign(hinput),bboxCheck,obj_solid))
			{
				state=PlayerState.onwall;
				onwalltimer=0;
				exit;
			}
			
		if (airmaskenabled)
			mask_index=maskair;
		else
			mask_index=masknormal;
	}
	
//Now move to either running or idle state if we land on the floor
var breaktoidleorrun=false;
if (place_meeting(x,y+gravMultiplier,obj_solid) and interactwithblocksenabled and yspeed==0)
	breaktoidleorrun=true;

var semisolid=instance_place(x,y+gravMultiplier,obj_semisolid);
if (semisolid!=noone and gravMultiplier==1)
	if (!place_meeting(x,y,obj_semisolid) and (sign(yspeed)==gravMultiplier or yspeed==0) and interactwithblocksenabled)
		breaktoidleorrun=true;
		
if (breaktoidleorrun)
	{
		if (impactsoundenabled)
			scr_play_sound(sound_impact,false,0);
			
		yspeed=0;
		
		if (splatenabled and timeinstate>20*maxxspeed)
			{
				yspeed=0;
				state=PlayerState.splat;
				sprite_index=sprite_splat;
				image_index=0;
				xspeed=0;
				scr_play_sound(sound_splat,0,0);
				if (global.currentinstance==id)
					scr_set_vibration(1,1,10);
				exit;
			}
		else
			{
				//Specific case here if we've buffered a jump
				if (jumpbuffertime>0 and jumpenabled and (place_meeting(x,y+gravMultiplier,obj_solid) or place_meeting(x,y+gravMultiplier,obj_semisolid)))
					{
						scr_jump();
						exit;
					}
			}
		if (xspeed==0 or !runenabled)
			{
				state=PlayerState.idle;
				exit;
			}
		else if (runenabled)
			{
				state=PlayerState.running;
				exit;
			}
	}
	
//If we haven't hit something, add on the fractional part of y again
//Woo that was a lot of checks before this wasn't it?
if (yspeed!=0 and !place_meeting(x,y+yfrac,obj_solid))
	y+=yfrac;
	
//Dashing
if (b_four and dashenabled and candash and dashcooldown==0)
	{
		state=PlayerState.dashing;
		exit;
	}

//Bird boi's carrying
if (birdmodeenabled and global.currentinstance==id)
	{
		carrytarget=noone;
		//For collision checks
		var x1=x+anchorx;
		var y1=y+anchory;
		var _y1=y1;
		y1+=sprite_get_height(mask_index)*0.5;
		//This does two repeats because it checks half the height of mask down then a full height down
		//That doesn't make sense oh well fuck you, future Ed
		repeat(2)
			{
				for (var i=0; i<array_length_1d(carryable);i+=1)
					{
						var inst=instance_place(x1,y1,carryable[i]);
						if inst!=noone
							{
								if inst.state=PlayerState.defeated or inst.state=PlayerState.dead
									{
										continue;
									}
								//Check the halfway point 
								//We need to check if we can actually get to the object but the problem is we might be picking up the solid object
								with (inst)
									{
										var x2=x+sprite_width*0.5-sprite_xoffset;
										var y2=bbox_top;
										var _coll=collision_line(x1,_y1,x2,y2,obj_solid,false,true);
									}
								if _coll!=noone
									{
										continue;
									}
								inst.outlineshader=true;
								carrytarget=inst;
								break;
							}
					}
				if carrytarget!=noone
					{
						break;
					}
				else
					{
						y1+=sprite_get_height(mask_index)*0.5;
					}
			}
		
		if b_four=true and carrytarget!=noone
			{
				state=PlayerState.carrying;
				exit;
			}
	}
	
//Sprites are a little annoying so we select it by object index if we don't use the default
sprite_index=sprite_air;

#region Ed
//This selection needs to specifically go in Ed's step code
//Speed can be between -12 and 10 so we want to select sprites as follows:
/*index 0-3 on the way up, so:
*/
if (object_index==obj_Ed)
	{
		if (scr_isBetween(yspeed,-12*gravMultiplier,0))
			{
				image_speed=0;
				image_index=3+floor(gravMultiplier*yspeed/3);
				image_index=max(image_index,1); //Skip the first frame, it is stupid
				//Obviously I could edit the animation but got to change all my math here if I do that and don't feel like it
			}
		/*index 4-6 on the way down:*/
		else if (scr_isBetween(yspeed,0,8*gravMultiplier))
			{
				image_speed=0;
				image_index=4+floor(yspeed/3);
			}
		/*Finally we just cycle through the last three frames*/
		else if (image_index<7)
			{
				image_index=7;
				image_speed=1;
			}
	}
#endregion

#region dr death
//First 3 frames moving up, next 3 moving down, last 2 repeat loop
if object_index=obj_drdeath_edspaceboss
	{
		if yspeed=clamp(yspeed,-12,0)
			{
				image_speed=0;
				image_index=2+floor(yspeed/3);
			}
		else if yspeed=clamp(yspeed,0,8)
			{
				image_speed=0;
				image_index=3+floor(yspeed/3);
			}
		else if image_index<6
			{
				image_index=6;
				image_speed=1;
			}	
	}
#endregion

#region cats
if (object_index==obj_Mig or object_index==obj_Sim or object_index==obj_Frankie)
	{
		if yspeed=clamp(yspeed,-8,-3)
			{
				image_speed=0;
				image_index=3+floor(yspeed/3);
			}
		else if yspeed=clamp(yspeed,-3,-1)
			{
				image_speed=0;
				image_index=3;
			}
		else if abs(yspeed)<1
			{
				image_speed=0;
				image_index=4;
			}
		else if yspeed=clamp(yspeed,1,3)
			{
				image_index=5;
			}
		else if image_index<6
			{
				//This should cycle the final frames
				image_index=7;
				image_speed=1;
			}
	}
#endregion

#region Eggbert
if object_index=obj_eggbert_hatched
	{
		if yspeed=clamp(yspeed,jumpheight,jumpheight*0.5)
			{
				image_speed=0;
				image_index=0
			}
		else if yspeed=clamp(yspeed,jumpheight*0.5,0)
			{
				image_speed=0;
				image_index=1;
			}
		else
			{
				//Cycle final frames
				if image_index<2
					{
						image_index=2;
					}
				image_speed=1;
			}
	}
#endregion

#region Appleworm
if object_index=obj_appleworm
	{
		image_speed=0;
	}
#endregion

#region Charlotte
if (object_index==obj_Charlotte)
	{
		if (yspeed==clamp(yspeed,jumpheight,0))
			{
				image_speed=0;
				image_index=3*(1-abs((yspeed/jumpheight)));
			}
		else if (yspeed==clamp(yspeed,0,maxyspeed*0.25))
			{
				image_index=2;
			}
		else if (image_index<3)
			{
				image_index=3;
				image_speed=1;
			}
	}
#endregion

#region New Deal
if (object_index==obj_newDeal)
	{
									//Move up
		if (sign(yspeed)<0)
			{
				image_index=0;
			}
		else						//Move down
			{
				image_index=2;
			}
		if (abs(yspeed)<2)			//Turn around
			{
				image_index=1;
			}
	}
#endregion
/*
#region bird boi
if object_index=obj_birdboi
	{
		if yspeed<=0
			{
				image_speed=1;
			}
		else
			{
				image_speed=0;
				image_index=2;
			}
	}
#endregion
*/