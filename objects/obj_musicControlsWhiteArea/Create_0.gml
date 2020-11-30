/// @description


theMusic=noone;
position=0;
musicOffset=0;

haspaused=false;
counter=0;

//This has one beat every 24.827s (3600/145 to be exact)
theMusic=audio_play_sound(mus_whiteOrbRhythm,0,false);
audio_sound_gain(theMusic,global.music_volume*global.music_on,0);
	
alarm[0]=60; //Music resync

//Lock the region
scr_regionlock(0,32,false);

newLaser=noone;

