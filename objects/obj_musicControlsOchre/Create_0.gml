/// @description


theMusic=noone;
position=0;
musicOffset=0;

haspaused=false;
counter=0;

theMusic=audio_play_sound(mus_Ochre_rhythm,0,false);
audio_sound_gain(theMusic,global.music_volume*global.music_on,0);
	
alarm[0]=60; //Music resync

locked[0]=false;