//Created: 23/05/19
//Last updated: 12/10/19

//We don't use this stuff anymore
//alarm[1]=1; //This is just to measure the frame rate
global.currentversion=201015;		//YYMMDD that I write this
global.roomspeed=60;
//dt=delta_time;

//This is just all variables I might need for general gameplay
global.playerpowerlevel=1;
global.currentinstance=noone;
global.Edhealth=2;
global.Edhealthmax=2;
global.deaths=0;
global.localdeaths=-1; //Dumbest variable name ever
global.maincharacter=obj_Ed;

//This is a data structure for holding dialogue boxes
global.dialoguequeue=ds_queue_create();
global.notificationqueue=ds_queue_create(); //Same but for notifications
global.dialoguemap=ds_map_create();

//Pausing
global.canpause=1;
global.softpause=0; //use this to stop accepting inputs
global.hardpause=0; //Use this for the actual pause menu
global.canleavelevel=true;

//Some other things
global.talkdistance=32; //distance you need to be within to talk to someone

//Music controls
global.sound_fx_on=1;
global.music_on=1;
global.sound_fx_volume=1;
global.music_volume=0.8;

//Room movement management
previous_room=room;
global.checkpoint[0]=noone; //Checkpoint ID
global.checkpoint[1]=noone; //Checkpoint location

//Don't forget to set a seed and also pick an RNG number incase we want random events
randomize();
global.rng=irandom(3);

//Now set up the event sets
scr_events_init();

//Set up the inventory and such
scr_inventory_init();
scr_instancemap_setup();
global.mapenhancergrid=ds_grid_create(5,0);

//Set up the room array and room sets
scr_roomarray_setup();
scr_roomsets_setup();

//Font
//global.font=font_add_sprite(spr_font,ord("a"),true,2);
global.font=fnt_standard;
scr_options_init();

//To do list
scr_create_todo();

//Save profiles
//Set up the files
//This makes sure the save files exist at game start
global.saveprofiles=ds_grid_create(1,3);
global.currentprofile=1; //This will get overwritten by the config

/*This crashes the game so uhh gonna guess it doesn't do anything important hopefully, i don't care at this point lol
var fname;
for (var i=1;i<=3;i+=1)
	{
		fname="save"+string(i)+".sav";
		if !file_exists(fname)
			{
				ds_grid_set(global.saveprofiles,0,i-1,"NO DATA");
				continue;
				//file=file_text_open_write(fname);
				//file_text_close(file);
			}
		ds_grid_set(global.saveprofiles,0,i-1,scr_save_game_getname(i));
		//I'm also going to make a backup of each file at startup because its easy to overwrite and mistake may be made
		file_copy(fname, fname+"1");
	}*/
	


global.loading=false;
global.gametoload=1;
global.restarting=false;

firstgame=false;
//Config file
fname="config.cfg";
if !file_exists(fname)
	{
		firstgame=true;
		scr_config_save();
	}
else
	{
		scr_config_load();
	}
	
scr_timetrials_init();
fname="times";
if (!file_exists(fname))
	{
		scr_timetrials_save();
	}
else
	{
		scr_timetrials_load();
	}
	
//For recording a demo
global.attract=true;
global.attract=false; //Comment out for recording a demo

//Turn transitions off for recording a demo pls (this is done automatically)
if (global.attract==true)
	{
		global.transitions=0;
	}

//For playing back a demo
scr_load_attract_data();

global.disallowedrooms=ds_list_create();

var _list=global.disallowedrooms;
#region add all rooms to the list - these are rooms where we don't allow pausing, maps etc
ds_list_add(_list,rm_main_menu);
ds_list_add(_list,room_setup);
ds_list_add(_list,rm_firsttime);
ds_list_add(_list,rm_language_select);
ds_list_add(_list,room_credits);
ds_list_add(_list,rm_splash);
ds_list_add(_list,rm_newGame);
ds_list_add(_list,rm_loadGame);
ds_list_add(_list,rm_loadAttract);
#endregion

exit;

//Here I will create a text file for when I want to update stuff
var _version=global.currentversion;
var changelogurl="https://eatkin.itch.io/other-minds/devlog/149173/may-2020-demo-update";
var downloadurl="https://eatkin.itch.io/other-minds";

var _map=ds_map_create();
ds_map_set(_map,"version",_version);
ds_map_set(_map,"changelogurl",changelogurl);
ds_map_set(_map,"downloadurl",downloadurl);

var _mapstring=ds_map_write(_map);
ds_map_destroy(_map);

var file=file_text_open_write("Update.txt");
file_text_write_string(file,_mapstring);
file_text_close(file);