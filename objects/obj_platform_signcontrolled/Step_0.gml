/// @description Moves
// You can write your code in this editor

/*Plan for this thing:
Moving when something jumps on it
We keep track of yunperturbed for collission checks
We keep track of instance number on top
If it increases, we apply a perturbation which lerps towards a perturbation value
Then once there it lerps back
If another instance joins while lerping back, it move towards the perturbation value again
*/

event_inherited();

if (global.hardpause==true)
	{
		scr_pause_alarms();
		exit;
	}

//Particles
if (scr_on_camera()==true and irandom(60)==0)
	{
		var xx=random(sprite_width);
		var yy=random(sprite_height);
		part_particles_create(global.partSys,x+xx,y+yy,global.collectibleParticle,1);
	}

//Destroy if off screen because this wasn't working before
if y<-sprite_height*1.5
	{
		event_perform(ev_alarm,0);
		exit;
	}

var _list=ds_list_create();

//Lets check if they player is on top and start moving if they are
if state=PlayerState.idle
	{
		//I'll use a collision line so it ONLY checks whats on top
		//Though this still buggers things up because there may be multiple instances
		//Okay apparently collision line list exists so I can use that!
		//But for now it doesn't actually matter, we just need at least one instance on top
		var player=collision_line(x,y-1,x+sprite_width,y-1,parent_possessable,0,1);
		//Player must be stationary or moving down, don't want to trigger platform by clipping through
		//Also make sure you're not WITHIN the platform!
		if player!=noone
			{
				if player.yspeed<0 or place_meeting(x,y,player)
					{
						player=noone;
					}
				else
					{
						state=PlayerState.moving;
						global.hint_events=scr_event_set_complete(global.hint_events,EVENTS_HINTS.FLOATING_PLATFORM)
					}
			}
	}
	
if state=PlayerState.moving
	{
		//The player on top can be anyone
		//So let's create a list of instances to move all of them as appropriate
		//Start timer to disappear when player leaves
		var _num=collision_line_list(x,y-1,x+sprite_width,y-1,parent_possessable,0,1,_list,false);		
		var i;
		for (i=0; i<_num; i+=1)
			{
				var inst=_list[| i];
				//This will remove the instance from the list if its below the surface of the platform
				if (inst.bbox_bottom>=y or inst.yspeed<0 or inst.interactwithblocksenabled==false)
					{
						ds_list_delete(_list,i);
						//Also set i back 1 because we've replaced the position in the list
						i-=1;
					}
				//As we're dynamically reshaping the list we need to have an exit condition
				if i=ds_list_size(_list)-1
					{
						break;
					}
			}
		//Update number of instances
		_num=ds_list_size(_list)
		if _num=0
			{
				//set alarm for 3 seconds
				if alarm[0]=-1
					{
						alarm[0]=180;
					}
			}
		else
			{
				alarm[0]=-1;
			}
		//Start to apply a perturbation
		if _num>instancesontop and !place_meeting(x,y,obj_semisolid)
			{
				var createParticles=false;
				if (perturb==0)
					{
						createParticles=true;
						perturb=1;
						yunperturbed=y;
						perturbationdir=1;
					}
				else if (perturbationdir==-1)
					{
						createParticles=true;
						perturbationdir=1;
					}
				if (createParticles==true)
					{
						var particleNum=irandom(10);
						repeat(particleNum)
							{
								var xx=x+random(sprite_width);
								var yy=y+sprite_height*0.5+random(sprite_height*0.5);
								part_particles_create(global.partSys,xx,yy,global.platformParticle,1);
							}
					}
			}
		instancesontop=_num;
		
		//Collission with signs
		//Check a point
		var x1, y1, x2, y2;
		x1=x+sprite_width*0.5;
		y1=yunperturbed+sprite_height*0.5;
		var _sign=instance_place(x1,y1,obj_sign_direction);
		//if _sign=noone
		//	{
		//		_sign=instance_place(x1,y1,obj_signman);
		//	}
		if _sign!=noone
			{
				//Get sign coordinates and check if they match
				with (_sign)
					{
						x2=x+(sprite_width*0.5-1);
						y2=y+(sprite_height*0.5-1);
						//What the fuck why do I need this?? Why are two idental sprite measuring DIFFERENTLY??!
						//if object_index=obj_signman
						//	{
						//		y2+=1;
						//	}
					}
				//This snaps them together
				if (x1==clamp(x1,x2,x2) and y1==clamp(y1,y2,y2) and _sign.state!=PlayerState.spinning)
					{
						x=x2-sprite_width*0.5;
						y=y2-sprite_height*0.5;
						//Changes the platform direction and sets the sign to spinning state
						var signdirection=_sign.dir;
						dir=signdirection;
						//_sign.active=1;
					}
			}
			
		//Jim signman collision
		var signman=collision_point(x1,y1,obj_signman,false,false);
		if signman!=noone
			{
				if signman.state!=PlayerState.spinning
					{
						//Changes the platform direction and sets the sign to spinning state
						var signdirection=signman.dir;
						dir=signdirection;
						//signman.active=1;
					}	
			}
		
		//Okay one final fix - if we're going down, we reverse dir if we are facing down and hit a wall - this is a really annoying specific case but whatever
		//Yeah I actually need this, I think I probably did something retarded in the past but I'm too afraid to try and fix this
		if (dir==3 and place_meeting(x,yunperturbed+sprite_height,obj_solid))
			dir=1;
		
		//Now we mobe
		//Oh god how many nested brackets???!

		var angle=pi*0.5*dir;
		repeat(xspeed)
			{
				var _xs=cos(angle);
				if !place_meeting(x+_xs,yunperturbed,obj_solid)
					{
						x+=_xs;
						if _num!=0
							{
								for (i=0; i<_num; i+=1)
									{
										with (_list[| i])
											{
												if !place_meeting(x+_xs,y,obj_solid)
													{
														x+=_xs;
													}
												if x<0 or x>room_width
													{
														x=xprevious;
													}
											}
									}
							}
					}
				else
					{
						dir+=2; //reverse direction when hitting a wall
						if dir>4
							{
								dir-=4;
							}
						break;
					}
			}
		//Remember that y axis is reversed so move in the negative y direction
		repeat(yspeed)
			{
				var _ys=sin(angle);
				//This is a special case since I messed with the collission boxes to get these working correctly urghrgufeafdsa
				//Sorry its an ugly way of doing it
				if dir=3 and place_meeting(x,yunperturbed-1-sprite_height*_ys,obj_solid)
					{
						dir+=2
						if dir>4
							{
								dir-=4;
							}
						break;
					}
				if !place_meeting(x,yunperturbed-_ys,obj_solid)
					{
						y-=_ys;
						if _num!=0
							{
								for (i=0; i<_num; i+=1)
									{
										with (_list[| i])
											{
												if !place_meeting(x,y-_ys,obj_solid)
													{
														y-=_ys;
													}
												else
													{
														//Fall through platform
														state=PlayerState.air;
													}
											}
									}
							}
							yunperturbed-=_ys;
					}
				else
					{
						dir+=2; //reverse direction when hitting a ceiling
						if dir>4
							{
								dir-=4;
							}
						break;
					}
			}
	//Now here we can apply the perturbation
	if perturb=1
		{
			var _y=y;
			if perturbationdir=1
				{
					y=lerp(y,yunperturbed+perturbamount,0.05);
					y=ceil(y);
					if y>=yunperturbed+perturbamount-0.2
						{
							y=yunperturbed+perturbamount;
							perturbationdir=-1;
						}
				}
			else
				{
					y=lerp(y,yunperturbed,0.05);
					y=floor(y);
					if y<yunperturbed+0.2
						{
							y=yunperturbed;
							perturb=0;
						}
				}
			//Update the carried objects y position
			var yperturbation=y-_y;
			if _num!=0
				{
					for (i=0; i<_num; i+=1)
						{
							with (_list[| i])
								{
									if !place_meeting(x,y+yperturbation,obj_solid)
										{
											y+=yperturbation;
										}
								}
						}
				}
		}
	}

ds_list_destroy(_list);