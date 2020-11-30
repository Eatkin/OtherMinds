//Created 04/08/19
//Last updated 04/08/19

//Updates listener position
if (global.currentinstance==noone)
	exit;

var listener=global.currentinstance;
audio_listener_orientation(0, 0, 1000, 0, -1, 0);
audio_listener_position(listener.x,listener.y,0);