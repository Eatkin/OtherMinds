/// @description States and stuff
// You can write your code in this editor

event_inherited();

scr_states_step();

if state=PlayerState.beingcarried
	{
		canhurtenabled=false;
	}
else
	{
		canhurtenabled=true;
	}

//Enemy behaviour - we want the worm to move away from the player if they're close by
//If they get to an impassable block, they turn around
//These worms will voluntarily commit suicide - but they're worms, they can't see lol
if global.currentinstance=id
	{
		exit;
	}
	
var player=instance_nearest(x,y,parent_main_character);
var xrange=128;
var yrange=128;
if state!=PlayerState.beingcarried and enemymoving=false and abs(player.x-x)<xrange and abs(player.y-y)<yrange and collision_line(player.x,player.y,x,y,obj_solid,false,true)=noone
	{
		enemymoving=true;
		attackdirection=scr_sign_nonzero(x-player.x);
	}
if enemymoving=true
	{
		if place_meeting(x+attackdirection*16,y,obj_solid) or scr_room_edge_check(attackdirection)
			{
				attackdirection*=-1;
			}
		s_hinput=attackdirection;
	}

if abs(player.x-x)>=xrange or state=PlayerState.beingcarried
	{
		enemymoving=false;
	}