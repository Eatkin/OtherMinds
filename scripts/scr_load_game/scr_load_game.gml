//Created 16/10/20
//Last updated 16/10/19

//Save game but in reverse
//NOTE WE CANNOT DIRECTLY LOAD THE STRUCTURES (Except the instance map)
//THIS WOULD POTENTIALLY OVERWRITE USEFUL INFORMATION
//SO THEY NEED LOOPS THROUGH AND COPYING TO THE RELEVANT STRUCTURES

global.loading=true;

#region cleanse old data
//Firsly lets erase our relevant structures
//Events - reinitialise to set it all to zero
scr_events_init();

//Inventory
var grid=global.inventory;
var gridheight=ds_grid_height(grid);
for (var i=0; i<gridheight;i+=1)
	ds_grid_set(grid,INVENTORY.QUANTITY,i,0);
	
//Instancemap
//The instance map is dynamically created as we go so just delete and replace with a new one
ds_grid_destroy(global.instancegrid);
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
	ds_grid_set(grid,TODO.STATUS,i,TODOSTATUS.UNDISCOVERED);
	
//Blank the map enhancer
ds_grid_resize(global.mapenhancergrid,ds_grid_width(global.mapenhancergrid),0);

//Dialogue map destroy and recreate
ds_map_destroy(global.dialoguemap);
global.dialoguemap=ds_map_create();
#endregion

var savenumber=argument0;
var file=file_text_open_read("save"+string(savenumber)+".OM");

//This file contains a couple header lines then the ds map string
file_text_readln(file);
file_text_readln(file);
var str=file_text_read_string(file);

var _datamap=ds_map_create();
ds_map_read(_datamap,str);

//Version number
//Used for any maintanence required for save games
var version=_datamap[? SAVE.VERSION];

//Find current player
var _charname=_datamap[? SAVE.PLAYER];
global.maincharacter=asset_get_index(_charname);
//Default to Ed if something went wrong
if (object_get_parent(global.maincharacter)!=parent_main_character)
	global.maincharacter=obj_Ed;
	
//Room to goto
var roomtogoto=_datamap[? SAVE.ROOM];
roomtogoto=asset_get_index(roomtogoto);

//previousroom
var pr=_datamap[? SAVE.PREVIOUSROOM];
pr=asset_get_index(pr);
controller_global.previous_room=pr;

//Player power level
global.playerpowerlevel=_datamap[? SAVE.POWERLEVEL];

//Deaths (probably unused)
global.deaths=_datamap[? SAVE.DEATHS];

//Load in a temp inventory
//Load the string
var invstring=_datamap[? SAVE.INVENTORY];
var inv=ds_grid_create(0,0);
ds_grid_read(inv,invstring);
var gridheight=ds_grid_height(inv);
var i,j,quant;
for (i=0;i<gridheight;i+=1)	{
	//Find the quantity, if it's larger then 0 we go write over the current quantity in the actual inventory
	quant=ds_grid_get(inv,INVENTORY.QUANTITY,i);
	if (quant>0) {
		//Find the object name in the temp inventory, then find a match in the global inventory and set the quantity
		var objname=ds_grid_get(inv,INVENTORY.OBJNAME,i);
		for (j=0; j<ds_grid_height(global.inventory);j+=1)
			if (ds_grid_get(global.inventory,INVENTORY.OBJNAME,j)==objname)
				ds_grid_set(global.inventory,INVENTORY.QUANTITY,j,quant);
		}
	}

//Destroy temp inventory
ds_grid_destroy(inv);

//Events - load in a list then use a useful script I wrote to convert that list to event data
var eventsstring=_datamap[? SAVE.EVENTS];
scr_list_to_events(eventsstring);

//Instance map is just a straight replacement
var mapstring=_datamap[? SAVE.ITEMMAP];
ds_grid_read(global.instancegrid,mapstring);

//Room array is more difficlt because it requires data substitutions
var arrstring=_datamap[? SAVE.ROOMARRAY];
var arr=ds_grid_create(0,0);
ds_grid_read(arr,arrstring);
var gridheight=ds_grid_height(arr);
var i,j,ref,orbs,secrets,secretnumber,discovered,roomname;
for (i=0;i<gridheight;i+=1)	{
	roomname=ds_grid_get(arr,ROOMARRAY.ROOMNAME,i);
	orbs=ds_grid_get(arr,ROOMARRAY.ORBSFOUND,i);
	secrets=ds_grid_get(arr,ROOMARRAY.SECRETSFOUND,i);
	secretnumber=ds_grid_get(arr,ROOMARRAY.SECRETSNUMBER,i);
	discovered=ds_grid_get(arr,ROOMARRAY.DISCOVERED,i);
	//Find the reference and write all this
	for (j=0;j<ds_grid_height(global.roomarray);j+=1)
		if (ds_grid_get(global.roomarray,ROOMARRAY.ROOMNAME,j)==roomname)	{
				ds_grid_set(global.roomarray,ROOMARRAY.ORBSFOUND,j,orbs);
				ds_grid_set(global.roomarray,ROOMARRAY.SECRETSFOUND,j,secrets);
				ds_grid_set(global.roomarray,ROOMARRAY.SECRETSNUMBER,j,secretnumber);
				ds_grid_set(global.roomarray,ROOMARRAY.DISCOVERED,j,discovered);
			}
	}

ds_grid_destroy(arr);

//Todo, an easy substitution by reference
var todostring=_datamap[? SAVE.TODO];
var todo=ds_grid_create(0,0);
ds_grid_read(todo,todostring);
var gridheight=ds_grid_height(todo);
var i,j,ref,status;
for (i=0;i<gridheight;i+=1)	{
		ref=ds_grid_get(todo,TODO.REF,i);
		status=ds_grid_get(todo,TODO.STATUS,i);
		//Overwrite status if NOT undiscovered
		var newHeight=ds_grid_height(global.todo);		//Super minor pointless optimisation lol
		if (status!=TODOSTATUS.UNDISCOVERED)
			for (j=0;j<newHeight;j+=1)
				if (ds_grid_get(global.todo,TODO.REF,j)==ref)
					ds_grid_set(global.todo,TODO.STATUS,j,status);
	}
//Final sort
ds_grid_sort(global.todo,TODO.STATUS,true);

ds_grid_destroy(todo);

//Finally the dialogue map, this is just a straight over-write
var dialoguestring=_datamap[? SAVE.DIALOGUEMAP];
ds_map_read(global.dialoguemap,dialoguestring);


//HP - you should load in with full hp so work that out however the hell I usually work it out
//Set health based on difficulty
//MaxHP is set in Ed's create event
var _hp
switch (global.difficulty)	{
	case DIFFICULTY.EXTRAEASY:					
	case DIFFICULTY.EASY:	
		_hp=3;
		break;
	case DIFFICULTY.NORMAL:
		_hp=2;
		break;
	case DIFFICULTY.HARD:
		_hp=1;
		break;
	case DIFFICULTY.EXTRAHARD:
		_hp=0;
		break;
	}
	
global.Edhealth=_hp;

//CLose file and clean up
file_text_close(file);
ds_map_destroy(_datamap);

//Now lets go to the room!
global.currentprofile=savenumber;
global.checkpoint[0]=noone;
global.checkpoint[1]=noone;
room_goto(roomtogoto);