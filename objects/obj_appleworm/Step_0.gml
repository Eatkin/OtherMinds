/// @description States and stuff
// You can write your code in this editor

event_inherited();

if (instance_exists(obj_transition))
	{
		exit;
	}

scr_states_step();

if state=PlayerState.beingcarried
	{
		canhurtenabled=false;
	}
else
	{
		canhurtenabled=true;
	}

if state=PlayerState.defeated
	{
		if myworm=noone or myworm.state=PlayerState.dead
			{
				myworm=instance_create_layer(x,y,layer,obj_worm);
				//The worm doesn't want to get stuck!!
				var collisiondir=0;
				if place_meeting(x+6,y,obj_solid)
					{
						collisiondir=1;
					}
				else if place_meeting(x-6,y,obj_solid)
					{
						collisiondir=-1;
					}
				if collisiondir!=0
					{
						with (myworm)
							{
								var timeout=0;
								while (place_meeting(x,y,obj_solid))
									{
										x-=collisiondir;
										timeout+=1;
										if timeout>6
											{
												break;
											}
									}
							}
					}
			}
	}

//Enemy behaviour - we just move back and forth at random intervals. Sometimes we stop before meeting a cliff edge
if global.currentinstance!=id
	{
		if (enemymoving==false)
			{
				var roll=irandom(60)
				if (roll!=0)
					{
						exit;
					}
				enemymoving=true;
			}
		if (place_meeting(x+24*directionfacing,y+1,obj_solid) or place_meeting(x+24*directionfacing,y+1,obj_semisolid))
			{
				s_hinput=directionfacing
			}
		else
			{
				enemymoving=false;
				directionfacing*=-1;
			}
		
		if place_meeting(x+directionfacing,y,obj_solid)
			{
				s_hinput=0;
				enemymoving=false;
				directionfacing*=-1;
			}
		
		//Sometimes we'll randomly stop
		var roll=irandom(180);
		if roll=0
			{
				roll=irandom(2);
				if (roll==0)
					{
						directionfacing*=-1;
					}
				enemymoving=false;
				s_hinput=0;
			}
	}