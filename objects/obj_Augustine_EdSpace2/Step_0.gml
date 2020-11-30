/// @description States and stuff
// You can write your code in this editor

event_inherited();

//Augustus is largely the same except he cannot be killed and he talks to you and he doesn't attack you

//exit if paused -Although this is built in we have additional code so its necessary
if (global.hardpause)
	{
		image_speed=0;
		exit;
	}
image_speed=1;
	
scr_states_step();

//Splat on the floor and drop the keys if player throws Augustine off a cliff
var createKey=false;
var hasKey=scr_inventory_check(obj_yellowKey,localinventory);
if (dialogueprevious==2 and ds_queue_empty(global.dialoguequeue) and !instance_exists(obj_yellowKey))
	createKey=true;

var fallenOffCliff=false;
//272 is arbitrary, but it indicated the point at which the player must have deliberately thrown Augustine off a cliff
if (state=PlayerState.splat and y!=clamp(y,272,ystart+16))
	{
		createKey=true;
		fallenOffCliff=true;
	}
	
if (fallenOffCliff)
	{
		scr_dialoguemap_init(4,4);
		if (!hasKey)
			scr_dialoguemap_init(6,6);
	}
	
if (createKey and hasKey)	
	{
		hasKey=false;
		instance_create_layer(x,y,layer,obj_yellowKey);
		scr_inventory_remove(obj_yellowKey,localinventory);
		scr_todo_complete(0);
	}