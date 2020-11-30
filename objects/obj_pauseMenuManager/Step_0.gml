/// @description

//Set the HUD stuff
//If we're on pausemenu.none do NOTHING with the HUD because we're no longer paused
//Add the select key
if (activeMenu==PauseMenu.Main or activeMenu==PauseMenu.Options)	{
	scr_HUD_set_tips_buttons(global.kb_b_one);
	scr_HUD_set_tips_text(scr_return_text(279));
	if (activeMenu!=PauseMenu.None)	{
		scr_HUD_add_tips_buttons(global.kb_b_two);
		scr_HUD_add_tips_text(scr_return_text(280));
	}
}
//Back button - this has to be an el-if because using add instead of set crashes the game -_-
else if (activeMenu!=PauseMenu.None)	{
	scr_HUD_set_tips_buttons(global.kb_b_two);
	scr_HUD_set_tips_text(scr_return_text(280));
}
//Nothing when rebinding a key or when closing the menu
if (instance_exists(obj_keyRebindPanel) or activeMenu==PauseMenu.None)
	scr_HUD_tips_clear();
	
var unpause=global.inputs[14];
//Can also press back
if (global.inputs[5] and activeMenu=PauseMenu.Main)
	unpause=true;
//var map=global.inputs[15];

//Unpause
if (unpause and global.hardpause)	{
	activeMenu=PauseMenu.None;
	global.inputs[14]=0;		//No dupe inputs pls
	var snd=audio_play_sound(snd_menu_shift,0,false);
	audio_sound_gain(snd,global.sound_fx_on*global.sound_fx_volume,0);
	audio_sound_pitch(snd,0.8);
}

//Open map
/*
if (map and !instance_exists(obj_map_screen))	{
	scr_set_vibration(0,0,0);
	global.inputs[15]=0;		//Make sure we don't hit the pause trigger again in the pause object's step event
	instance_create_layer(x,y,layer,obj_map_screen);
}*/
	
//Check all menu containers are off screen then destroy
if (activeMenu==PauseMenu.None)	{
	var len=array_length_1d(menu);
	var totalTimers=0;
	for (var i=0; i<len; i+=1)	{
		var menuTimer=menu[i].timer;
		totalTimers+=menuTimer;
	}
	
	if (totalTimers==0)	{
		//Loop thru and destroy all menu stuff
		for (var i=0; i<len; i+=1)
			instance_destroy(menu[i]);
		instance_destroy();	
	}
			
}