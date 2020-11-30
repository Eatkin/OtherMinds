/// @description

instance_create_layer(x+sprite_width*0.5,y+sprite_width*0.5,layer,obj_smoke);
scr_set_vibration(1,1,5);
var emitter=instance_create_layer(x,y,layer,obj_sound_emitter);
emitter.soundid=snd_pop;