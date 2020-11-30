/// @description Movement and states
// You can write your code in this editor

// Inherit the parent event
event_inherited();

//exit if paused
if global.hardpause=1
	{
		exit;
	}

scr_states_step();

#region owner updates and dialogue
//Update owner's pos
owner.x=x;
owner.y=y;

//Update owner sprite index
with (owner)
	{
		if active!=1 and state!=PlayerState.spinning
			{
				//Move to the right, image_index-=1
				if sign(x-xprevious)=1
					{
						image_index=round((image_index+1)/11)*11-2;
					}
				else if sign(x-xprevious)=-1
					{
						image_index=round((image_index+1)/11)*11+1;
					}
				else
					{
						image_index=round((image_index+1)/11)*11;
					}
			}
	}
	
//Mirror the owner - we also need to send signal to the owner if we need to change sprites
//I.e. when Jim Signman has been defeated!
if state!=PlayerState.defeated and state!=PlayerState.dead
	{
		//owner.visible=true;
		sprite_index=owner.sprite_index;
		image_index=owner.image_index;
		image_speed=0;
	}
else
	{
		//owner.visible=false;
	}

#endregion

//Behaviour

//We want to move towards the player if the player is within a certain range and can be seen and also is facing away
//We also want to attack any enemies that are going to attack him
//Code will be similar to that of the gloops

if global.currentinstance=id or scr_on_camera()=false or global.softpause=true or global.hardpause=true
	{
		exit;
	}
	
//Variable init
var movetowardsplayer=true;
var attackenemy=false;

//This is ripped straight from the Gloop code
//Only difference is it only searches for enemies
var attackrange=128;
var _nearest;

//Go from the first nearest instance
for (i=1; i<=instance_number(parent_enemy);i+=1)
	{
		//We don't need to refind the 2nd nearest instance because we've already found it
		_nearest=scr_instance_nth_nearest(x,y,parent_enemy,i);
		
		//Range check
		if distance_to_object(_nearest)>attackrange
			{
				_nearest=noone;
				break;
			}
		//Check if we should attack the found instance
		//This is nested so to break the loop if all conditions are passed
		/*if _nearest.enemiesattackenabled=false
			{
				_nearest=noone;
				continue;
			}
		else
			{*/
				//Check for line of sight
				if collision_line(x,y,_nearest.x,_nearest.y,obj_solid,false,true)!=noone or scr_on_camera(_nearest)=false
					{
						_nearest=noone;
						continue;
					}
				else
					{
						if _nearest.state=PlayerState.defeated or _nearest.state=PlayerState.dead
							{
								_nearest=noone;
								continue;
							}
						break;
					}
			//}
	}
	
if _nearest!=noone
	{
		attackenemy=true;
	}

//Attack following by following player
if attackenemy=true
	{
		//Jesus this is confusing, why didn't I just do middle centre offset for the sign
		var nearestx=_nearest.x+_nearest.sprite_width*0.5-_nearest.sprite_xoffset;
		var centre=x+sprite_width*0.5-sprite_xoffset;
		var dist=nearestx-centre;
		var _dir=sign(dist); //1 if enemy is to the right, -1 if its to the left
		s_hinput=_dir;
		if dist<32 
			{
				if irandom(10)=0
					{
						s_jump=true;
					}
				//Stop the h_input if we're gonna actually land on the enemy
				if place_meeting(x,_nearest.y,_nearest)
					{
						s_hinput=0;
					}
			}
		
		//Jump over obstacles
		if place_meeting(x+_dir*4,y,obj_solid)
			{
				s_jump=true;
			}
	}
else
	{
		var player=instance_nearest(x,y,parent_main_character);
		var playerx=player.x+player.sprite_width*0.5-player.sprite_xoffset;
		var centre=x+sprite_width*0.5-sprite_xoffset;
		var dist=playerx-centre;
		var _dir=sign(dist);
		var dist=abs(playerx-centre);
		//Move towards player after attacking enemies
		//This almost completely solves the spazzing issues
		var mindist=64+centre%16-playerx%16;
		var maxdist=128;
		if dist==clamp(dist,mindist,maxdist)
			{
				//We should set a bunch of conditions that break the movetowardsplayer conditions
				//First check their actual distance (accounts for x and y)
				if distance_to_object(player)>maxdist
					{
						movetowardsplayer=false;
					}
				//Then check which way they are facing
				//Therefore the player should be facing the same direction
				if player.directionfacing!=_dir
					{
						movetowardsplayer=false;
					}
		
				//Now finally check the player is actually in our line of sight
				if collision_line(centre,bbox_top,player.x,player.y,obj_solid,false,false)!=noone
					{
						movetowardsplayer=false;
					}
			}
		else
			{
				movetowardsplayer=false;
			}
	
		if movetowardsplayer=true
			{
				//Duplicating this incase it gets "lost"
				var dir=sign(player.x-x); //1 for the sign moving right, -1 for the sign moving left
				var centre=x+sprite_width*2-sprite_xoffset;
				s_hinput=dir;
				//Jump if it finds anything in the way
				//Check with respect to sprite width because there's not much of a bounding box
				if place_meeting(x+dir*4,y,obj_solid)
					{
						s_jump=true;
					}
				//Then make sure we commit to the jump instead of turning around in the air
				if state=PlayerState.air
					{
						s_jumphold=true;
						if xspeed!=0
							{
								s_hinput=sign(xspeed);
							}
					}
			}
	}