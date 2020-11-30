//Created: 12/06/19
//Last updated: 19/07/19

//We just need to fall off cliffs if necessary at the moment
//Might add more stuff later
//Also need player to get squashed and die underneath it lol

if (global.hardpause)
	exit;

var gravMultiplier=dsin(global.gravdirection);
var bbox=(gravMultiplier==1) ? bbox_bottom : bbox_top;

if (!place_meeting(x,y+gravMultiplier,obj_solid) and (!place_meeting(x,y+gravMultiplier,obj_semisolid) or place_meeting(x,y,obj_semisolid)))
	{
		yspeed+=global.gravstrength*gravMultiplier;
		if (myEmitter!=noone)
			{
				instance_destroy(myEmitter);
				myEmitter=noone;
			}
	}
	
yspeed=clamp(yspeed,-maxyspeed,maxyspeed);


repeat(ceil(abs(yspeed)))
	{
		if !place_meeting(x,y+sign(yspeed),obj_solid) and (!place_meeting(x,y+sign(yspeed),obj_semisolid) or place_meeting(x,y,obj_semisolid))
			{
				var characterList=ds_list_create();
				var characterNum=instance_place_list(x,y+1,parent_possessable,characterList,false);
				if (characterNum>0)
					{
						for (var i=0; i<characterNum; i+=1)
							{
								var ysp=sign(yspeed);
								with (ds_list_find_value(characterList,i))
									{
										if (!place_meeting(x,y+ysp,obj_solid))
											{
												y+=ysp;
											}
									}
							}
					}
				ds_list_destroy(characterList);
				y+=sign(yspeed);
			}
		else
			{
				var bboxdust=bbox+8*gravMultiplier;		//Account for the dust's origin point
				var dustleft=instance_create_layer(bbox_left,bboxdust,"players",obj_dust_trail);
				var dustright=instance_create_layer(bbox_right,bboxdust,"players",obj_dust_trail);
				dustright.image_xscale=-1;
				dustleft.image_yscale=gravMultiplier;
				dustright.image_yscale=gravMultiplier;
				
				var emit=instance_create_layer(x,y,layer,obj_sound_emitter);
				emit.soundid=snd_spikes_eject;
				scr_set_vibration(1,1,10);
				var shake=1;
				scr_camera_screenshake_x(shake);
				scr_camera_screenshake_y(shake);
				yspeed=0;
				//Some particles too
				var xx=x+random(sprite_width);
				var yy=bbox;
				part_particles_create(global.partSys,xx,yy,global.dustParticle,5+irandom(5));
				break;
			}
	}
	
//Kay we also need to make sure it doesn't hang stupidly over the edge so if it's over its centre of gravity
//We will auto-push it off
//Could do a tilt animation but whatever maybe later
//I don't think it would fit either
if (x==xprevious)
	{
		var width=bbox_right-bbox_left;
		if !position_meeting(x+width*0.5,bbox+gravMultiplier,obj_solid) and !position_meeting(x+width*0.5,bbox+gravMultiplier,obj_semisolid)
			{
				if position_meeting(x,bbox+gravMultiplier,obj_solid) or position_meeting(x,bbox+gravMultiplier,obj_semisolid)
					{
						if !place_meeting(x+1,y,obj_solid)
							{
								x+=1;
							}
					}
				if position_meeting(x+width,bbox+gravMultiplier,obj_solid) or position_meeting(x+width,bbox+gravMultiplier,obj_semisolid)
					{
						if !place_meeting(x-1,y,obj_solid)
							{
								x-=1;
							}
					}
			}
		#region shit
		/*Fucking garbage-ass code that I wrote when I must have been retarded
		Literally what the fuck, this is the most unecessarily complicated collision checks I've ever seen
		Also I changed it because it doesn't even work
		if instance_position(x+sprite_get_width(mask_index)/2,y+sprite_get_height(mask_index)+1,obj_solid)=noone and instance_position(x+sprite_get_width(mask_index)*0.5,y+sprite_get_height(mask_index)+1,obj_semisolid)=noone
			{
				//This works
				if instance_position(x,y+sprite_get_height(mask_index)+1,obj_solid)!=noone or instance_position(x,y+sprite_get_height(mask_index)+1,obj_semisolid)!=noone
					{
						if !place_meeting(x+1,y,obj_solid)
							{
								x+=1;
							}
					}
				//This doesn't ??? AHH 
				//Okay now it does - wrong collision function
				if instance_position(x+sprite_get_width(mask_index)-1,y+sprite_get_height(mask_index)+1,obj_solid)!=noone or instance_position(x+sprite_get_width(mask_index)-1,y+sprite_get_height(mask_index)+1,obj_semisolid)!=noone
					{
						if !place_meeting(x-1,y,obj_solid)
							{
								x-=1;
							}
					}
			}
		*/
		#endregion
		//I don't know why but this fixes the audio not stopping bug, oh well
		if (myEmitter!=noone)
			{
				instance_destroy(myEmitter);
				myEmitter=noone;
			}
	}
else
	{
		if (myEmitter==noone)
			{
				myEmitter=instance_create_layer(x,y,layer,obj_sound_emitter);
				myEmitter.soundid=snd_drag;
				myEmitter.mode=EMITTER.LOOP;
			}
		//This should be continuous and won't stack
		scr_set_vibration(0.8,0.8,1);
		if (irandom(5)==0)
			{
				var xx=x+random(sprite_width);
				var yy=(gravMultiplier==1)	?	bbox_bottom	:	bbox_top;
				part_particles_create(global.partSys,xx,yy,global.dustParticle,irandom(5));
			}
	}
	
//Update emitter position
if (instance_exists(myEmitter))
	{
		myEmitter.x=x+sprite_width*0.5;
		myEmitter.y=y+sprite_height*0.5;
	}
	
//Now I just need to push any possessables along with the block
var dx=x-xprevious;
var possessable=instance_place(x+sign(dx),y,parent_possessable)
if possessable=global.currentinstance
	{
		exit;
	}
if dx=0 or possessable=noone
	{
		exit;
	}
else
	{
		possessable.x+=dx;
		//We make sure we don't crush a main character by moving the character, push block and pushing instance back to their previous position
		if object_get_parent(possessable.object_index)=parent_main_character
			{
				var moved=true;
				with (possessable)
					{
						if place_meeting(x,y,obj_solid)
							{
								x=xprevious;
								moved=false;
							}
					}
				if moved=false
					{
						x=xprevious;
						var pushing=instance_place(x-dx,y,parent_possessable)
						if pushing!=noone
							{
								pushing.x=pushing.xprevious;
							}
					}
			}
	}
	
//Destroy out of room
if (y!=clamp(y,-sprite_height,room_height))
	{
		instance_destroy();
	}