/// @description


//Okay this one is 180 bpm, so 3bps, 1/20 bpf, i.e. 20 frames per beat!
theMusic=noone;
position=0;
musicOffset=0;
//fpb=30; //Frames per beat, nice and easy!
/*timeline_index=timeline_officegauntlet;
timeline_running=true;
timeline_speed=0; //We MANUALLY set the timeline
timeline_loop=false;*/

haspaused=false;
counter=0;

theMusic=audio_play_sound(mus_edspace2_rhythm,0,false);
audio_sound_gain(theMusic,global.music_volume*global.music_on,0);
	
alarm[0]=60; //Music resync

obj_cannon.activated=false;