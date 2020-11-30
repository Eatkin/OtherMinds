/// @description Insert description here
// You can write your code in this editor

if (global.hardpause)
	scr_pause_alarms();

if ds_queue_empty(global.notificationqueue)
	{
		xpos=xbegin;
		exit;
	}
	
if (!showingnotification and !instance_exists(obj_transition))	{
	var snd=audio_play_sound(snd_new_notification,0,0);
	audio_sound_gain(snd,global.sound_fx_volume*global.sound_fx_on,0);
	showingnotification=true;
	//Set the sprite dimensions
	var _text=ds_queue_head(global.notificationqueue);
	var maxWidth=string_width(_text)+hpadding*2;
	var sep=string_height("A");
	var maxHeight=string_height_ext(_text,sep,max(98,maxWidth))+vpadding*2;		//This accounts for unusally long word (*coughGermancough*)
	
	hrepeats=minWidth/16;
	if (maxWidth>minWidth)
		hrepeats=ceil(maxWidth/16);
	
	vrepeats=ceil(maxHeight/16);
	
	alarm[0]=30; //Lerp in
}

//Lerp in
if (!global.hardpause)	{
	if (alarm[0]>0)
		xpos=lerp(xpos,xtarget,0.1);

	//Lerp out
	if (alarm[2]>0)
		xpos=lerp(xpos,xbegin,0.1);
}