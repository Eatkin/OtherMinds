/// @description States and stuff
// You can write your code in this editor

event_inherited();

if (instance_exists(obj_transition))
	exit;

scr_states_step();

//Behaviour
if (global.currentinstance==id or scr_on_camera()==false or global.softpause==true or global.hardpause==true)
	exit;

var player=parent_main_character;
var flip=false;

if (seenPlayer and global.gravdirection==90)
	flip=true;
	
directionfacing=scr_sign_nonzero(player.x-x);

if (abs(player.x-x)<playerRange and collision_line(x,y,player.x,player.y,obj_solid,false,true)==noone)
	{
		flip=true;
		seenPlayer=true;
	}

//Check if we want to flip, if grav direction is normal and if we're idle
if (flip and global.gravdirection==90 and state=PlayerState.idle)
	s_b_four=true;