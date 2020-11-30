/// @description Set up grid and surfaces and other variables
// You can write your code in this editor

//This creates a ds grid called 'themap' with all the data you need depending what room you're in!
global.hardpause=true;
scr_setup_mapdata();
audio_pause_all();

with (obj_music)
	{
		if nowplaying!=noone
			{
				audio_resume_sound(nowplaying);
				audio_sound_gain(nowplaying,0.1*global.music_volume*global.music_on,500);
			}
	}

var snd=audio_play_sound(snd_menu_shift,0,0);
audio_sound_gain(snd,global.sound_fx_volume*global.sound_fx_on,0);

panning_sound=audio_play_sound(snd_map_pan,0,1);
audio_sound_gain(panning_sound,global.sound_fx_volume*global.sound_fx_on,0);
audio_sound_pitch(panning_sound,0);

//I'm a dumb idiot, wait actually I'm not I'm just so smart I'm ahead of the game!!!!
//I'm never going to remember why I wrote that comment lol haha lol

//These will be useful for panning
guiheight=display_get_gui_height();
guiwidth=display_get_gui_width();
border=128; //This will be how much border before we draw the map
cellsize=64;

//Now lets find the furthest right and furthest down coordinates so we can set borders
//It just loops through and every time there's a larger value available, it gets replaced
var xmax=guiwidth/cellsize;
var ymax=guiheight/cellsize;
for (i=0; i<ds_grid_height(themap);i+=1)
	{
		xmax=max(xmax,ds_grid_get(themap,MAPDATA.X,i)+ds_grid_get(themap,MAPDATA.XSCALE,i));
		ymax=max(ymax,ds_grid_get(themap,MAPDATA.Y,i)+ds_grid_get(themap,MAPDATA.YSCALE,i));
	}


//We should be allowed to pan the map so let's set up a surface to draw to
surfx=0;
surfy=guiheight;
mapsurf=surface_create(xmax*cellsize+border*2,ymax*cellsize+border*2);

//We'll also set up some drawing variables to lerp the map screen in
ydraw=guiheight;
movedir=1; //Moving up! Similar to the pause menu! (Infact its literally the same)
moveenabled=0; //Can we pan around the map

//Let's set up the 'camera' coordinates
for (var i=0;i<ds_grid_height(themap);i+=1)
	{
		if ds_grid_get(themap,MAPDATA.ROOMNUMBER,i)=room
			{
				break;
			}
	}

//Centre it on the current room
//This does not work!
//It does now it was because I am so dumb lol
camx=ds_grid_get(themap,MAPDATA.X,i)*64+32*ds_grid_get(themap,MAPDATA.XSCALE,i)-guiwidth/2+border;
camy=ds_grid_get(themap,MAPDATA.Y,i)*64+32*ds_grid_get(themap,MAPDATA.YSCALE,i)-guiheight/2+border;


//Get the room set name pls:
var roomarrayref=-1;
roomsetname="Please tell Ed he is a dumb idiot";
for (var i=0; i<ds_grid_height(global.roomarray); i+=1)
	{
		if (ds_grid_get(global.roomarray,ROOMARRAY.ROOM,i)==room)
			{
				roomarrayref=ds_grid_get(global.roomarray,ROOMARRAY.ROOMSET,i);
				break;
			}
	}
for (var i=0; i<ds_grid_height(global.roomsets); i+=1)
	{
		if (ds_grid_get(global.roomsets,ROOMGROUPCONSTS.REF,i)==roomarrayref)
			{
				roomsetname=ds_grid_get(global.roomsets,ROOMGROUPCONSTS.NAME,i);
				break;
			}
	}

roomsetname=string_upper(roomsetname);

//Let's set a variable to tell us whether we're using the map enhancer or not
//Then I can just flip that when I've added the map enhancer item to the game
mapenhancerenabled=false;
/*if inventory check map enhancer, enable
Yes add this later when the map enhancer actually exists*/
//Okay temporarily I've added trasure map 2 = the map enhancer
if (scr_inventory_check(obj_treasure_map_2))
	mapenhancerenabled=true;