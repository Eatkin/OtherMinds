//Created 20/01/20
//Last updated 20/01/20

/*What to do -
DONE 1. When carrying=noone, we lerp to carry target
DONE 2. Always check we can still get to carry target
>>>>>>>>>>>THIS IS IMPORTANT NOT DONE3. Make sure we exit carrying state if we leave bird boi as Sage
DONE 4. Now its just the usualy flying and move loops but with additional collision checks
-We can either have them let go when pushed against a wall, or stop us rigidly, whichever feels better
DONE5. Also depth sorting - when you grab something, its depth should move up one, when you let go, it moves down one*/

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
	
	
//Now I've added bomb blocks the carrying object can cease to exist
//Also got to make sure the TARGET exists otherwise we get crashes (again)
var exitState=false;

if (carrying!=noone and !instance_exists(carrying))
	exitState=true;

if (!instance_exists(carrytarget))
	exitState=true;

if (exitState)
	{
		state=PlayerState.air;
		carrying=noone;
		exit;
	}
	
//Lerp towards target
if carrying=noone
	{
		var x1=x;
		var x2=carrytarget.x+carrytarget.sprite_width*0.5-carrytarget.sprite_xoffset-anchorx*directionfacing;
		var y1=y;
		var y2=carrytarget.bbox_top-anchory;
		//Time out or if we're too far away from the target
		if abs(y2-y1)>2*sprite_get_width(mask_index) or timeinstate>120
			{
				state=PlayerState.air;
				carrytarget=noone;
				exit;
			}
		//Target lost, because its falling or something
		if y2>y+anchory+sprite_get_width(mask_index)
			{
				state=PlayerState.air;
				exit;
			}
		var x_lerp=lerp(x1,x2,0.1);
		var y_lerp=lerp(y1,y2,0.1);
		if (!place_meeting(x_lerp,y_lerp,obj_solid))
			{
				x=x_lerp;
				y=y_lerp;
			}
		else
			{
				state=PlayerState.air;
				exit;
			}
		if abs(x-x2)<1 and abs(y-y2)<1
			{
				x=x2;
				y=y2;
				carrying=carrytarget;
				carrying.state=PlayerState.beingcarried;
				//This will only be >1 for things such as 32x32 blocks
				carryweight=max(1,(sprite_get_width(carrying.masknormal)*sprite_get_height(carrying.masknormal))/(16*32));
				scr_play_sound(snd_item_bounce,false,0);
				//Layering weirdness
				var pushable=false;
				if (carrying.object_index==parent_push or object_is_ancestor(carrying,parent_push))
					{
						pushable=true;
					}
				if (pushable==true)
					{
						carryingdepth=carrying.layer; //Now a misleading variable name
						carrying.depth=depth+1;
					}
				xspeed=0;
				yspeed=0;
			}
	}
else
	{
		//Normal controls here - we can flap and move up and down as usual but have to also move the object that's being carried
		//So we have usual controls, plus release button to drop target
		
		//Obviously this causes loads of angry bugs:
		carrying.x=x+anchorx*directionfacing-carrytarget.sprite_width*0.5+carrytarget.sprite_xoffset//-anchorx*directionfacing;
		
		//Flap wings + various gravity conditionals
		if jumpinput=1// and yspeed>=0
			{
				yspeed+=jumpheight;
				yspeed=max(-3,yspeed);
			}
		var _g=global.gravstrength*0.1;
		//This stops the weird looking sudden switch between yspeed=1 to yspeed=-1
		if yspeed=clamp(yspeed,0,1) and holdingjumpinput=false
			{
				_g*=3;
			}
		if vinput>0 and yspeed>=0
			{
				yspeed=lerp(yspeed,(1-vinput)*_g,0.2);
				if abs(yspeed)<0.1
					{
						yspeed=0;
					}
			}
		else if vinput<0
			{
				yspeed+=_g*(1+abs(vinput));
			}
		else
			{
				yspeed+=_g;
			}
		if yspeed>0
			{
				yspeed=clamp(yspeed,0,maxyspeed);
			}
			
		//Now we can apply left and right movement
		if hinput!=0
			{
				//add acceleration but make sure we don't exceed max speed
				//Note i use a modified version so we slow down faster in the air
				if smoothaccelerationenabled=true
					{
						scr_add_xacceleration_smooth((1.5/carryweight)*hinput);
					}
				else
					{
						scr_add_xacceleration_linear((1.5/carryweight)*hinput);
					}
			}
		else if decelerationenabled=true
			{
				//Reduce speed - stop if we get to slow
				if smoothaccelerationenabled=true
					{
						scr_subtract_xacceleration_smooth();
					}
				else
					{
						scr_subtract_xacceleration_linear();
					}
			}
			
		//Now a modified xmove loop that also checks the bounding boxes of what is being carried
		#region xmove loop
		var speedoperator;
		if abs(xspeed)<0
			{
				speedoperator=xspeed;
			}
		else
			{
				speedoperator=sign(xspeed);
			}
	
		var _list=ds_list_create();
		repeat(ceil(abs(xspeed)))
			{
				//This is an annoying condition I have to include for some reason
				if scr_room_edge_check()=1
					{
						if hinput=0 or state=PlayerState.dashing
							{
								xspeed=0;
							}
						break;
					}
				var collision=false;
				#region first collision checks
				if place_meeting(x+sign(speedoperator),y,obj_solid)
					{
						collision=true;
					}
				with (carrying)
					{
						if place_meeting(x+sign(speedoperator),y,obj_solid)
							{
								collision=true;
							}
					}
				#endregion
				if collision=false
					{
						#region collision checks with characters
						var collision_2=false;
						if (object_is_ancestor(carrying.object_index,parent_push) or carrying.object_index==parent_push)
							{
								ds_list_clear(_list);
								with (carrying)
									{
										instance_place_list(x+sign(speedoperator),y,parent_possessable,_list,false);
									}
								if ds_list_empty(_list)=false
									{
										var inst;
										for (var i=0; i<ds_list_size(_list); i+=1)
											{
												inst=ds_list_find_value(_list,i);
												with (inst)
													{
														if !place_meeting(x+sign(speedoperator),y,obj_solid) and scr_room_edge_check(speedoperator)=false
															{
																x+=sign(speedoperator);
															}
														else
															{
																collision_2=true;
															}
													}
											}
									}
							}
						#endregion
						if collision_2=false
							{
								x+=speedoperator;
								carrying.x+=speedoperator;
							}
						else
							{
								xspeed=0;
								break;
							}
					}
				else
					{
						xspeed=0;
						break;
					}
			}
		ds_list_destroy(_list);
		#endregion
		
		//A simplified ymove loop because I hope to god I don't do anything mor ecomplicated with the carrying state
		var _list=ds_list_create();
		repeat(floor(abs(yspeed)))
			{
				if y<-120 and yspeed<0
					{
						yspeed=max(yspeed,0);
						continue;
					}
				var collision=false;
				var _ys=yspeed;
				if place_meeting(x,y+sign(yspeed),obj_solid)
					{
						collision=true;
					}
				with (carrying)
					{
						if place_meeting(x,y+sign(_ys),obj_solid)
							{
								collision=true;
							}
					}
				//Don't crush poor innocent possessables
				if (object_is_ancestor(carrying.object_index,parent_push) or carrying.object_index==parent_push)
					{
						ds_list_clear(_list);
						with (carrying)
							{
								if (place_meeting(x,y+sign(_ys),parent_possessable) and sign(_ys)==1)
									{
										collision=true;
									}
								instance_place_list(x,y-1,parent_possessable,_list,false);
							}
						//We just need to mark collision as true if we're gonna crush them, the pushable block handles the rest
						if ds_list_empty(_list)=false and sign(_ys)=-1
							{
								var inst;
								for (var i=0; i<ds_list_size(_list); i+=1)
									{
										inst=ds_list_find_value(_list,i);
										with (inst)
											{
												//I guess this is a floating point error or something because Ed dies all the time if we don't multiply by 2
												if place_meeting(x,y+sign(_ys),obj_solid) or place_meeting(x,y+2*sign(_ys),obj_solid)
													{
														collision=true;
													}
											}
									}
							}
					}
				if collision=false
					{
						y+=sign(yspeed);
						carrying.y+=sign(yspeed);
					}
				else
					{
						yspeed=0;
						break;
					}
			}
		ds_list_destroy(_list);
		
		//Exit if you kill the carrying object
		if carrying.state=PlayerState.dead or carrying.state=PlayerState.defeated
			{
				state=PlayerState.air;
				carrying.state=PlayerState.idle;
				carrying.layer=carryingdepth;
				carrying=noone;
				exit;
			}
	}
	
//Finally we can let go of our target
if b_four=true or global.currentinstance!=id
	{
		state=PlayerState.air;
		if carrying!=noone
			{
				carrying.state=PlayerState.idle;
				var pushable=false;
				if (carrying.object_index==parent_push or object_is_ancestor(carrying,parent_push))
					{
						pushable=true;
					}
				if (pushable==true)
					{
						carrying.layer=carryingdepth;
					}
			}
		carrying=noone;
		exit;
	}
	
//Also sprite selection
sprite_index=sprite_carrying;
mask_index=maskair;