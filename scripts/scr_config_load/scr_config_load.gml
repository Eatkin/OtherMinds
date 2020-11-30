//Created 12/09/19
//Last updated 12/09/19

//File is called config.cfg
//We want to store controls, options and save profile information
//Let's create some lists to save to a load from I had a stroke

//Loads the config
var file=file_text_open_read("config.cfg");
//First line is the version number so we'll skip that
file_text_readln(file);
var graph=file_text_read_string(file);
file_text_readln(file);
var key=file_text_read_string(file);
file_text_readln(file);
var pad=file_text_read_string(file);
file_text_readln(file);
var sound=file_text_read_string(file);
file_text_readln(file);
var game=file_text_read_string(file);
file_text_readln(file);
//This will be used for loading the last played game (i.e. a continue game option)
global.currentprofile=file_text_read_real(file);

//Read the version number incase we need to do modifications
file_text_readln(file);
var version=file_text_read_real(file);

file_text_close(file);

//Now lets decode the lists
var graph_list=ds_list_create();
var key_list=ds_list_create();
var pad_list=ds_list_create();
var sound_list=ds_list_create();
var game_list=ds_list_create();
//var save_list=ds_list_create(); I don't know what this was for
ds_list_read(graph_list,graph);
ds_list_read(key_list,key);
ds_list_read(pad_list,pad);
ds_list_read(sound_list,sound);
ds_list_read(game_list,game);

//Graphics
window_set_fullscreen(ds_list_find_value(graph_list,0));
global.windowscale=ds_list_find_value(graph_list,1);
global.transitions=ds_list_find_value(graph_list,2);
global.vsync=ds_list_find_value(graph_list,3);
global.font=ds_list_find_value(graph_list,4);
//I'm removing this because it now tries to find the value from the gamepad description
//global.gamepadtype=ds_list_find_value(graph_list,5);
global.brightness=ds_list_find_value(graph_list,6);

display_reset(0,global.vsync);

//Keys - wow this is fun
#region keys
global.kb_left=ds_list_find_value(key_list,0);
global.kb_right=ds_list_find_value(key_list,1);
global.kb_up=ds_list_find_value(key_list,2);
global.kb_down=ds_list_find_value(key_list,3);
global.kb_altup=ds_list_find_value(key_list,4);
global.kb_altdown=ds_list_find_value(key_list,5);
global.kb_altleft=ds_list_find_value(key_list,6);
global.kb_altright=ds_list_find_value(key_list,7);
global.kb_b_one=ds_list_find_value(key_list,8);
global.kb_b_two=ds_list_find_value(key_list,9);
global.kb_b_three=ds_list_find_value(key_list,10);
global.kb_b_four=ds_list_find_value(key_list,11);
global.kb_r_one=ds_list_find_value(key_list,12);
global.kb_r_two=ds_list_find_value(key_list,13);
global.kb_r_three=ds_list_find_value(key_list,14);
global.kb_l_one=ds_list_find_value(key_list,15);
global.kb_l_two=ds_list_find_value(key_list,16);
global.kb_l_three=ds_list_find_value(key_list,17);
#endregion keys
#region pad
global.gp_left=ds_list_find_value(pad_list,0);
global.gp_right=ds_list_find_value(pad_list,1);
global.gp_up=ds_list_find_value(pad_list,2);
global.gp_down=ds_list_find_value(pad_list,3);
global.gp_b_one=ds_list_find_value(pad_list,4);
global.gp_b_two=ds_list_find_value(pad_list,5);
global.gp_b_three=ds_list_find_value(pad_list,6);
global.gp_b_four=ds_list_find_value(pad_list,7);
global.gp_r_one=ds_list_find_value(pad_list,8);
global.gp_r_two=ds_list_find_value(pad_list,9);
global.gp_r_three=ds_list_find_value(pad_list,10);
global.gp_l_one=ds_list_find_value(pad_list,11);
global.gp_l_two=ds_list_find_value(pad_list,12);
global.gp_l_three=ds_list_find_value(pad_list,13);
#endregion

//sound
global.sound_fx_on=ds_list_find_value(sound_list,0);
global.music_on=ds_list_find_value(sound_list,1);
global.sound_fx_volume=ds_list_find_value(sound_list,2);
global.music_volume=ds_list_find_value(sound_list,3);
global.sound_3d=ds_list_find_value(sound_list,4);

//Gameplay
global.helpbar=ds_list_find_value(game_list,0);
global.hpposition=ds_list_find_value(game_list,1);
global.tips=ds_list_find_value(game_list,2);
global.difficulty=ds_list_find_value(game_list,3);
if version>1
	{
		global.vibration=ds_list_find_value(game_list,4);
	}

//Destroy the lists
ds_list_destroy(graph_list);
ds_list_destroy(key_list);
ds_list_destroy(pad_list);
ds_list_destroy(sound_list);
ds_list_destroy(game_list);
//ds_list_destroy(save_list);