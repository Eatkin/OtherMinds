//Created 28/09/19
//Last updated 28/09/19

//Arg0 is the save number
//Name is stored in global.saveprofiles
//Also update config for the current profile

var savenum=argument0;
var savename=argument1;

//Blank map enhancer although it should already be blanked
ds_grid_resize(global.mapenhancergrid,ds_grid_width(global.mapenhancergrid),0);

//Set the save profiles grid
ds_grid_set(global.saveprofiles,0,savenum-1,savename);
//Set this to the current profile
global.currentprofile=savenum;
//Save it to the config file
scr_config_save();

//Set health based on difficulty
var _hp
switch (global.difficulty)
	{
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
global.deaths=0;
global.playerpowerlevel=1;
//Go to the first room!
room_goto(room_Tutorials_1);