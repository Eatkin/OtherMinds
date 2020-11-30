/// @description States and stuff
// You can write your code in this editor

event_inherited();

scr_states_step();

//Make sure the head pats don't get interrupted by other behaviours
if (state==PlayerState.petcat)
	exit;
	
	
//I copied this from the cats - its a generic follow code
//But he also attacks enemies
var followplayer=false;
var overpit=false;
var attackenemy=false;

var enemy=instance_nearest(x,y,parent_enemy);
if (enemy!=noone and enemy.state!=PlayerState.defeated)
	{
		var dist=abs(enemy.x-x);
		var mindist=8;
		var maxdist=128;
		var _dir=sign(enemy.x-x);
		var collision=collision_line(x,bbox_top,enemy.x,enemy.bbox_top,obj_solid,false,true);
		if (dist==clamp(dist,0,maxdist) and collision==noone and y=clamp(y,enemy.y-128,enemy.y+128))
			{
				attackenemy=true;
			}
			
		if (attackenemy==true and dist>mindist)
			{
				s_hinput=_dir;
			}
		if (place_meeting(x+xspeed*3,y,enemy))
			{
				var roll=irandom(round(dist/8))
				if (roll==0)
					{
						s_jump=true;
					}
			}
	}

if (attackenemy==false)
	{
		var player=instance_nearest(x,y,parent_main_character);
		var dist=abs(player.x-x);
		var mindist=24;
		var maxdist=128;
		var _dir=sign(player.x-x);
		var collision=collision_line(x,bbox_top,player.x,player.bbox_top,obj_solid,false,true);
		if (dist==clamp(dist,mindist,maxdist) and collision==noone and y==clamp(y,player.y-128,player.y+128))
			{
				followplayer=true;
			}
	
		if (followplayer==true)
			{
				s_hinput=_dir;
			}
	}
if (place_meeting(x+sign(xspeed)*max(abs(xspeed)*2,4),y,obj_solid) and state!=PlayerState.air)
	{
		s_jump=true;
	}

//This jumps at any cliff edges detected
var col_pos=x+xspeed*2;
if (state!=PlayerState.air and !place_meeting(col_pos,y+1,obj_solid) and !place_meeting(col_pos,y+1,obj_semisolid) and col_pos==clamp(col_pos,0,room_width))
	{
		s_jump=true;
	}

//Hold jump and try go back to xsafe
if (state==PlayerState.air)
	{
		s_jumphold=true;
		//Check if we're over a 'bottomless' pit (actually only checks approx 1.5x screen height)
		if (followplayer==false and attackenemy==false)
			{
				overpit=true;
				for (var i=1; i<=8; i+=1)
					{
						if (place_meeting(x,y+32*i,obj_solid) or place_meeting(x,y+32*i,obj_semisolid))
							{
								overpit=false;
								break;
							}
					}
				//So we try go to safety if over a hole, otherwise we just commit to the jump we made UNLESS we are within a larger range of the player
				if overpit=true
					{
						var safedist=abs(xsafe-x);
						var safedir=sign(xsafe-x);
						if (safedist>16)
							{
								//This has purpose - there is a quicker turnaround time if we release all keys and then re-press
								if (sign(xspeed)!=-safedir)
									{
										s_hinput=safedir;
									}
							}
					}
				else if (xspeed!=0 and dist>maxdist*2)
					{
						s_hinput=sign(xspeed);
					}
				else
					{
						s_hinput=_dir;
					}
			}
	}

var abovespikes=false;
for (var i=0; i<64; i+=4)
	{
		if (place_meeting(x,y+i,obj_spikes))
			{
				abovespikes=true;
				//Jump if we're touching spikes
				if (i==0)
					s_jump=true;
				break;
			}
	}
if (abovespikes==true)
	{
		if (sign(xspeed)==0)
			{
				s_hinput=choose(1,-1);
			}
		else
			{
				s_hinput=sign(xspeed);
			}
	}