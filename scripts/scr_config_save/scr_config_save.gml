//Created 12/09/19
//Last updated 12/09/19

//File is called config.cfg
//We want to store controls, options and save profile information
//Let's create some lists to save to a load from I had a stroke

//argument0 - true for if the file is being created for the first time

var profile=global.currentprofile;
/*Find the profile if we need to
Basically if global.currentprofile==4 then we don't save it, so instead we nede to find the REAL current profile
Then store it for later use
*/
if (global.currentprofile>3)	{
	//Loads the config
	var file=file_text_open_read("config.cfg");
	//First line is the version number so we'll skip that
	repeat(6)
		file_text_readln(file);
	profile=file_text_read_real(file);
	file_text_close(file);
}

//Graphics
var graph_list=ds_list_create();
ds_list_add(graph_list,window_get_fullscreen());
ds_list_add(graph_list,global.windowscale);
ds_list_add(graph_list,global.transitions);
ds_list_add(graph_list,global.vsync);
ds_list_add(graph_list,global.font);
ds_list_add(graph_list,global.gamepadtype);
ds_list_add(graph_list,global.brightness);

//Control
//Well isn't this a fun one
var key_list=ds_list_create();
var pad_list=ds_list_create();
#region keys
ds_list_add(key_list,global.kb_left);
ds_list_add(key_list,global.kb_right);
ds_list_add(key_list,global.kb_up);
ds_list_add(key_list,global.kb_down);
ds_list_add(key_list,global.kb_altup);
ds_list_add(key_list,global.kb_altdown);
ds_list_add(key_list,global.kb_altleft);
ds_list_add(key_list,global.kb_altright);
ds_list_add(key_list,global.kb_b_one);
ds_list_add(key_list,global.kb_b_two);
ds_list_add(key_list,global.kb_b_three);
ds_list_add(key_list,global.kb_b_four);
ds_list_add(key_list,global.kb_r_one);
ds_list_add(key_list,global.kb_r_two);
ds_list_add(key_list,global.kb_r_three);
ds_list_add(key_list,global.kb_l_one);
ds_list_add(key_list,global.kb_l_two);
ds_list_add(key_list,global.kb_l_three);
#endregion
#region pad
ds_list_add(pad_list,global.gp_left);
ds_list_add(pad_list,global.gp_right);
ds_list_add(pad_list,global.gp_up);


ds_list_add(pad_list,global.gp_down);
ds_list_add(pad_list,global.gp_b_one);
ds_list_add(pad_list,global.gp_b_two);
ds_list_add(pad_list,global.gp_b_three);
ds_list_add(pad_list,global.gp_b_four);
ds_list_add(pad_list,global.gp_r_one);
ds_list_add(pad_list,global.gp_r_two);
ds_list_add(pad_list,global.gp_r_three);
ds_list_add(pad_list,global.gp_l_one);
ds_list_add(pad_list,global.gp_l_two);
ds_list_add(pad_list,global.gp_l_three);
#endregion

//Sound
var sound_list=ds_list_create();
ds_list_add(sound_list,global.sound_fx_on);
ds_list_add(sound_list,global.music_on);
ds_list_add(sound_list,global.sound_fx_volume);
ds_list_add(sound_list,global.music_volume);
ds_list_add(sound_list,global.sound_3d);

//Gameplay
var game_list=ds_list_create();
ds_list_add(game_list,global.helpbar);
ds_list_add(game_list,global.hpposition);
ds_list_add(game_list,global.tips);
ds_list_add(game_list,global.difficulty);
ds_list_add(game_list,global.vibration);

//Now write to the file
var version=1;

var file=file_text_open_write("config.cfg");
file_text_write_real(file,version);
file_text_writeln(file);
file_text_write_string(file,ds_list_write(graph_list));
file_text_writeln(file);
file_text_write_string(file,ds_list_write(key_list));
file_text_writeln(file);
file_text_write_string(file,ds_list_write(pad_list));
file_text_writeln(file);
file_text_write_string(file,ds_list_write(sound_list));
file_text_writeln(file);
file_text_write_string(file,ds_list_write(game_list));
file_text_writeln(file);
//Store the last played profile for continue game UNLESS it's 4, in which case we're using level select
file_text_write_real(file,profile); //Store the last played profile

//We might update options in future so lets save a version number
var version=global.currentversion;
file_text_writeln(file);
file_text_write_real(file,version);
file_text_close(file);

//Don't forget to destroy the lists
ds_list_destroy(graph_list);
ds_list_destroy(key_list);
ds_list_destroy(pad_list);
ds_list_destroy(sound_list);
ds_list_destroy(game_list);