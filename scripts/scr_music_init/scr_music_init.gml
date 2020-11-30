//Created 18/07/19
//Last updated 18/07/19

//Boots up the bank of music into an array
//I need to also add looping information to this
//basically just need a MUSIC.MAINLOOP for loop start
//Then MUSIC.LOOPEND for the position to start repeating
musicarray[MUSIC.SOUND_ID, 0 ]=mus_edspace1;
musicarray[MUSIC.MAINLOOP, 0 ]=8.727;
musicarray[MUSIC.LOOPEND,  0 ]=34.909;

musicarray[MUSIC.SOUND_ID, 1]=mus_menu;
musicarray[MUSIC.MAINLOOP, 1]=8;
musicarray[MUSIC.LOOPEND,  1]=24;
//28 bars, 175 bpm
musicarray[MUSIC.SOUND_ID, 2]=mus_boss_edspace1;
musicarray[MUSIC.MAINLOOP, 2]=5.486;
musicarray[MUSIC.LOOPEND,  2]=38.4;
//This is one beat too long I think (not anymore!)
musicarray[MUSIC.SOUND_ID, 3]=mus_edspace1_outdoors;
musicarray[MUSIC.MAINLOOP, 3]=0.343;
musicarray[MUSIC.LOOPEND,  3]=43.973;
//16 bars, 117 bpm
musicarray[MUSIC.SOUND_ID, 4]=mus_edhouse;
musicarray[MUSIC.MAINLOOP, 4]=0.513;
musicarray[MUSIC.LOOPEND,  4]=33.338;
//Cellar music, 110bpm
musicarray[MUSIC.SOUND_ID, 5]=mus_cellar;
musicarray[MUSIC.MAINLOOP, 5]=34.909;
musicarray[MUSIC.LOOPEND,  5]=61.09;
//Ed Garden, same as main house theme
musicarray[MUSIC.SOUND_ID, 6]=mus_bonus_bedroom117bpm;
musicarray[MUSIC.MAINLOOP, 6]=0.513;
musicarray[MUSIC.LOOPEND,  6]=33.338;
//"Sky" music
musicarray[MUSIC.SOUND_ID, 7]=mus_sky;
musicarray[MUSIC.MAINLOOP, 7]=0;
musicarray[MUSIC.LOOPEND,  7]=83; //Guess
//Banjo, 104 BPM, 24 beats in intro, 232 in whole song
musicarray[MUSIC.SOUND_ID, 8]=mus_ochre_2;
musicarray[MUSIC.MAINLOOP, 8]=13.846;
musicarray[MUSIC.LOOPEND,  8]=133.846;
//Challenge music, not looped
musicarray[MUSIC.SOUND_ID, 9]=mus_edspace1_challenge;
musicarray[MUSIC.MAINLOOP, 9]=0;
musicarray[MUSIC.LOOPEND,  9]=50;
//EdSpace alt theme, 100bpm in 6/8 with 24 bars - so 72 bs
musicarray[MUSIC.SOUND_ID, 10]=mus_edspace1_2;
musicarray[MUSIC.MAINLOOP, 10]=0;
musicarray[MUSIC.LOOPEND,  10]=43.2;
//Ochre Hill challenge, not looped
musicarray[MUSIC.SOUND_ID, 11]=mus_ochre_challenge;
musicarray[MUSIC.MAINLOOP, 11]=0;
musicarray[MUSIC.LOOPEND,  11]=50;
//Tutorial, 95 bpm, 24 bars (of 4 beats)
musicarray[MUSIC.SOUND_ID, 12]=mus_tutorial;
musicarray[MUSIC.MAINLOOP, 12]=20.211;
musicarray[MUSIC.LOOPEND,  12]=60.632;
//Not Tubular Bells, 165.5 beats at 90bpm = 90/60 bps= 6/9spb
musicarray[MUSIC.SOUND_ID, 13]=mus_ventilation;
musicarray[MUSIC.MAINLOOP, 13]=0;
musicarray[MUSIC.LOOPEND,  13]=113;
//Pizz strings, 42s
musicarray[MUSIC.SOUND_ID, 14]=mus_town;
musicarray[MUSIC.MAINLOOP, 14]=0;
musicarray[MUSIC.LOOPEND,  14]=42;
//EdSpace theme - 60 bpm
musicarray[MUSIC.SOUND_ID, 15]=mus_edspace2;
musicarray[MUSIC.MAINLOOP, 15]=0
musicarray[MUSIC.LOOPEND,  15]=172;
//Overworld nighttime
musicarray[MUSIC.SOUND_ID, 16]=mus_overworldDark;
musicarray[MUSIC.MAINLOOP, 16]=21.333;
musicarray[MUSIC.LOOPEND,  16]=64;
//EdSpace 2 boss - 150 bpm
musicarray[MUSIC.SOUND_ID, 17]=mus_edspace2_boss;
musicarray[MUSIC.MAINLOOP, 17]=0;
musicarray[MUSIC.LOOPEND,  17]=78.4;

//Initialise any variables that we need
nowplaying=noone;
nowplayingsong=-1;
fadingout=noone;
fadingoutsong=-1;

//These will be used for the looping information (in milliseconds)
mainlooptime=0;
loopendtime=0;