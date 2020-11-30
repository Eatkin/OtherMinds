//Created 09/09/19
//Last updated 09/09/19

//There is no menu at the moment so this just quits the game
//It needs to empty any savable data though
//This is borrowed from the loda game stuff so should be good

//Save the game
if (global.attract==false)
	{
		scr_save_game(global.currentprofile);
	}

//Re-initialise the events
scr_events_init();

//Blank map enhancer
ds_grid_resize(global.mapenhancergrid,ds_grid_width(global.mapenhancergrid),0);

//Undo cheats
global.fatmode=false;
global.moonwalk=false;
scr_load_language_set();
global.debugging=false;
global.maincharacter=obj_Ed;

//Inventory
//Sets all quantities to 0
var grid=global.inventory;
var gridheight=ds_grid_height(grid);
var i;
for (i=0; i<gridheight;i+=1)
	{
		ds_grid_set(grid,INVENTORY.QUANTITY,i,0);
	}
	
//Instancemap
//The instance map is dynamically created as we go so just delete and replace
ds_grid_destroy(global.instancegrid)
scr_instancemap_setup();

//Roomarray
//To restore defaults we're better off destroying and starting again
ds_grid_destroy(global.roomarray);
scr_roomarray_setup();

//Todo
//We'll overwrite every todo with undiscovered
var grid=global.todo;
var gridheight=ds_grid_height(grid);
for (i=0; i<gridheight;i+=1)
	{
		ds_grid_set(grid,TODO.STATUS,i,TODOSTATUS.UNDISCOVERED);
	}
	
//Delete the dialogue map
ds_map_destroy(global.dialoguemap);
global.dialoguemap=ds_map_create();
	
//Delete checkpoint data
global.checkpoint[0]=noone;
global.checkpoint[1]=noone;
global.localdeaths=-1;

//Update the continue game!!!
if (global.attract==false)
	{
		scr_config_save();
	}
else
	{
		//Get a new random seed because if we've been on attract mode, we've moved to a known seed
		randomise();
	}

//Clear the notification queue
ds_queue_clear(global.notificationqueue);

global.attract=false;

if (instance_exists(obj_showroomset))
	{
		with (obj_showroomset)
			{
				instance_destroy();
			}
	}

room_goto(rm_main_menu);