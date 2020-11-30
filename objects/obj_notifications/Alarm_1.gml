/// @description Stay on screen
// You can write your code in this editor

alarm[2]=30;
if (ds_queue_empty(global.notificationqueue))
	{
		exit;
	}
var snd=audio_play_sound(snd_notification_close,0,0);
audio_sound_gain(snd,global.sound_fx_volume*global.sound_fx_on,0);