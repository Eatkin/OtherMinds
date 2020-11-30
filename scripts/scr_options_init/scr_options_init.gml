//Created 31/08/19
//Last updated 31/08/19

//This will be used to set up various game options
global.helpbar=true; //Show the help bar
global.hpposition=POSITION.BOTTOMLEFT; //Position of hearts
global.tips=true;
global.transitions=true;
global.windowscale=1;
var width=480;
var height=270;
while ((global.windowscale+2)*width<=display_get_width() or (global.windowscale+2)*height<=display_get_height())
	{
		global.windowscale+=1;
	}

global.sound_3d=true;
global.brightness=1;
global.vibration=true;

global.difficulty=DIFFICULTY.NORMAL;
global.gamepadtype=PAD.XBOX;

global.language=LANGUAGE.ENGLISH;

global.vsync=true;
//Cheats
global.fatmode=false;
global.moonwalk=false;

//Turn this off for public release!
global.debugging=true;
global.debugging=false;

if (global.debugging)
	scr_index_rooms();