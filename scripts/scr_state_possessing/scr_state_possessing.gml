//Created: 30/05/19
//Last updated: 30/05/19

//Firstly we'll cancel the target if we press the button again
//Other exit conditions also
var b_three=global.inputs[6];

if global.currentinstance!=self
	{
		b_three=0;
	}

//Emergency exit
if (!instance_exists(target))
	{
		state=PlayerState.idle;
		path_end();
		//canpossess=1; Important not to include this otherwise it re-triggers possessing state
		//I think it gets reset in anystate script or something
		target=noone;
		xspeed=0;
		yspeed=0;
		exit;
	}

var exitscript=0;
//Exit conditions
if b_three=1
	{
		exitscript=1;
	}

if target.state=PlayerState.defeated or target.state=PlayerState.dead
	{
		exitscript=1;
	}

//This might happen if the enemy is running away really fast
if path_get_length(sage_path)>=possessionrange*2
	{
		exitscript=1;
	}
	
if exitscript=1
	{
		state=PlayerState.idle;
		path_end();
		//canpossess=1; Important not to include this otherwise it re-triggers possessing state
		//I think it gets reset in anystate script or something
		target=noone;
		xspeed=0;
		yspeed=0;
		exit;
	}
		

if pathavailable=1
	{
		path_start(sage_path,path_speed,path_action_stop,false);
		path_speed+=acceleration;
		path_speed=clamp(path_speed,0,maxspeed);
	}
var x_target=target.x+target.sprite_width/2-target.sprite_xoffset;
var y_target=target.y+target.sprite_height/2-target.sprite_yoffset;

//Once we hit the target we change targets and kill ourselves
//This should have an alternative where Sage goes back to idle and gets told his level is too low
if abs(x-x_target)<=sprite_width and abs(y-y_target)<=sprite_height
	{
		//This is if your power level is too low
		if global.playerpowerlevel<target.powerlevel
			{
				var textobj=instance_create_layer(x_target,y_target,layer,obj_text);
				textobj.text=scr_return_text(272)+string(target.powerlevel);
				scr_play_sound(snd_sage_nope,false,0);
				gainoverride=1;
				state=PlayerState.idle;
				target=noone;
				xspeed=0;
				yspeed=0;
				exit;
			}
		target.outlineshader=false;
		global.currentinstance=target;
		sage_grid=noone;
		scr_set_vibration(1,1,10);
		instance_destroy();
	}
	
sprite_index=sprite_possessing;


#region OLD CODE - REPLACED WITH PATHFINDING
/*
//Move towards target
var angle=arctan2(y_target-y,x_target-x);
xspeed=maxspeed*cos(angle);
yspeed=maxspeed*sin(angle);

//Now move (hopefully)
repeat(abs(ceil(xspeed)))
	{
		if !place_meeting(x+sign(xspeed),y,obj_solid)
			{
				x+=sign(xspeed);
			}
		else
			{
				xspeed=0;
				break;
			}
	}

repeat(abs(ceil(yspeed)))
	{
		if !place_meeting(x,y+sign(yspeed),obj_solid)
			{
				y+=sign(yspeed);
			}
		else
			{
				yspeed=0;
				break;
			}
	}*/
#endregion