//Created 04/08/19
//Last updated 04/08/19

emitterid=audio_emitter_create();
audio_emitter_position(emitterid,x,y,0);
soundplaying=noone;

var guiwidth=display_get_gui_width();
falloffref=guiwidth/4;
falloffmax=guiwidth;
gainoverride=1; //Used for manually setting sound volume
pitchoverride=1;
falloffmaxoverride=0;

audio_falloff_set_model(audio_falloff_none); //This is because I manually update the gain myself