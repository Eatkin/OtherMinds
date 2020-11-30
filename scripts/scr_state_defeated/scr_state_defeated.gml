//Created 06/10/19
//Last updated 11/10/19

//Well this script ended up a goddamn mess

var gravMultiplier=dsin(global.gravdirection);

//Let's make it worse, first we deal with Eggbert
#region Eggbert
if object_index=obj_eggbert
	{
		//instance create eggbert the bird
		var bird=instance_create_layer(x,y,layer,obj_eggbert_hatched);
		instance_create_layer(x,y,"Lighting",obj_eggbertbroken);
		instance_create_layer(x,y,layer,obj_smoke);
		//What? why did I do this?
		//global.currentinstance=bird;
		global.overworld_events=scr_event_set_complete(global.overworld_events,OVERWORLD_EVENTS.EGGBERTHATCHED);
		var emit=instance_create_layer(x,y,layer,obj_sound_emitter);
		emit.soundid=snd_pop;
		bird.alarm[0]=30;
		global.softpause=true;
		instance_destroy();
		exit;
	}
#endregion

//Wait until Jim Signman has stopped spinning then select the correct sprite
#region Jim signman sprite selection
if spinningenabled=true and sprite_index!=sprite_defeated
	{
		var _cantthinkofavariablename=floor((image_index+1)%11);
		if _cantthinkofavariablename!=clamp(_cantthinkofavariablename,-2,2)
			{
				exit;
			}
		else
			{
				var dir=round((image_index+1)/11);
				if dir=1
					{
						sprite_defeated=spr_Jim_die_up;
					}
				else if dir=2
					{
						sprite_defeated=spr_Jim_die_left;
					}
				else if dir=3
					{
						sprite_defeated=spr_Jim_die_down;
					}
				else
					{
						sprite_defeated=spr_Jim_die_right;
					}
			}
	}
#endregion

//This is for the pink bullets to reverse their direction when you kill them
if (reversewhendefeatedenabled and timeinstate==0)
	{
		xspeed=-sign(xspeed)*maxxspeed*2;
		yspeed=-yspeed;
		maxxspeed=abs(xspeed);
	}
	
//Eject sage
if (global.currentinstance==id and object_get_parent(object_index)!=parent_main_character)
	scr_spawn_Sage();
	
//Update sprite
if (shoesenabled and felloffcliff)
	{
		if (sprite_index!=sprite_shoes)
			{
				scr_play_sound(snd_fall_off_cliff,false,0);
				image_index=0
				sprite_index=sprite_shoes;
				y=room_height-sprite_height*0.5;
				if (gravMultiplier=-1)
					y=sprite_height*0.5;
			}
	}
else
	{
		if sprite_index!=sprite_defeated
			{
				sprite_index=sprite_defeated;
				image_index=0;
				//Reset speeds
				if (!fallwhendefeatedenabled and !reversewhendefeatedenabled)
					xspeed=0;
					
				//Gravity invert
				if (gravityFlipEnabled and global.gravdirection!=90)
					scr_gravityInvert();
			}
		else
			{
				if (!reversewhendefeatedenabled)
					{
						yspeed+=global.gravstrength*gravMultiplier;
						if (yspeed>maxyspeed)
							yspeed=maxyspeed;
					}
				repeat(abs(ceil(yspeed)))
					{
						if (!interactwithblocksenabled)
							y+=sign(yspeed);
						//This also has to make sure we aren't IN a semisolid otherwise we just kind of stay there looking dumb
						else if (!place_meeting(x,y+sign(yspeed),obj_solid) and (!place_meeting(x,y+sign(yspeed),obj_semisolid) or place_meeting(x,y,obj_semisolid)))
							y+=sign(yspeed);
						else
							{
								if (explodeonwallsenabled)
									{
										var emitter=instance_create_layer(x,y,"controllers",obj_sound_emitter);
										emitter.soundid=sound_explode;
										instance_destroy();
									}
								yspeed=0;
							}
					}
					
				//Keep instance close by
				var outsideRoom=(y!=clamp(y,-sprite_height,room_height+sprite_height)) ? true : false;				
				var yfix=(gravMultiplier==1) ? room_height+sprite_height : -sprite_height;
				if ((gravMultiplier==1 and y<=yfix) or (gravMultiplier==-1 and y<=yfix))
					outsideRoom=false;
				if (outsideRoom)
					{
						y=yfix
						yspeed=0;
						state=PlayerState.dead;
						exit;
					}
			}
	}
	
if (fallwhendefeatedenabled)
	{
		yspeed+=global.gravstrength*gravMultiplier;
		//yspeed=clamp(yspeed,-maxyspeed,maxyspeed)
		if (!interactwithblocksenabled)
			x+=xspeed;
		else
			{
				repeat(abs(ceil(xspeed)))
					{
						if (!place_meeting(x+sign(xspeed),y,obj_solid))
							x+=sign(xspeed);
						else
							{
								xspeed=0;
								if (explodeonwallsenabled)
									{
										var emitter=instance_create_layer(x,y,"controllers",obj_sound_emitter);
										emitter.soundid=sound_explode;
										instance_destroy();
									}
								break;
							}
					}
			}
	}
else if (reversewhendefeatedenabled)
	{
		x+=xspeed;
		xspeed=clamp(xspeed,-maxxspeed,maxxspeed);
		yspeed=clamp(yspeed,-maxyspeed,maxyspeed);
	}
else if (image_index>image_number-0.5)
	{
		if (object_get_parent(object_index)=parent_enemy)
			{
				if( scr_inventory_check(obj_heart,localinventory))
					{
						scr_inventory_remove(obj_heart,localinventory);
						instance_create_layer(x,y,"objects",obj_heart);
					}
			}
		state=PlayerState.dead;
	}
	
if (timeinstate<60 and global.currentinstance==id)
	{
		var vibamount=2*abs(dcos(timeinstate));
		vibamount=clamp(vibamount,0.5,0.8);
		scr_set_vibration(vibamount,vibamount,1);
	}