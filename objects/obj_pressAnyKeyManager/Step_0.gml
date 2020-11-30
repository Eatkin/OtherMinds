/// @description

anyKeyAlpha=scr_easeOutQuart(min(1,timer));

timer+=timerDir*0.01;
if (timer>=1.1)
	timerDir*=-1;
if (timer<=0)
	timerDir*=-1;
	
if (!active or instance_exists(obj_transition))
	exit;
	
var snd=noone;

if ((keyboard_check_pressed(vk_anykey) or scr_detect_gamepad_input()) and obj_mainMenuManager.activeMenu==Menu.PressAnyKey)	{
	obj_mainMenuManager.activeMenu=Menu.Main;
	snd=audio_play_sound(snd_menu_confirm,0,false);
}

if (snd!=noone)
	audio_sound_gain(snd,global.sound_fx_volume*global.sound_fx_on,0);