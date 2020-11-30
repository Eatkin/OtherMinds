/// @description

var height=sprite_get_height(spr_spikes);
instance_create_layer(x,bbox_bottom-height,"objects",obj_ochrespikes);
instance_create_layer(x+16,bbox_bottom-height,"objects",obj_ochrespikes);
scr_set_vibration(1,1,30);
var snd=audio_play_sound(snd_cannon_into_wall,0,0);
audio_sound_gain(snd,global.sound_fx_volume*global.sound_fx_on,0);
instance_destroy();