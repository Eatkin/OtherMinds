/// @description

//Hard pause to prevent movement, pause audio
//Could soft pause but that's disables the help bar in a genius move by me, well done
global.softpause=true;

//Fade background music to a low level
with (obj_music)
	if (nowplaying!=noone)
		audio_sound_gain(nowplaying,0.1*global.music_volume*global.music_on,500);
	
moveenabled=0;
changingrooms=false;
movedir=1;
var snd=audio_play_sound(snd_menu_shift,0,0);
audio_sound_gain(snd,global.sound_fx_volume*global.sound_fx_on,0);
menu_x=display_get_gui_width()*1.25; //Start at the RIGHT of the screen and lerp left - we overshoot to allow a bit of a smoother transition
menu_y=display_get_gui_height()*0.125;
menuwidth=sprite_get_width(spr_pausemenuthindoublewidth);
menuheight=sprite_get_height(spr_pausemenuthindoublewidth);

//Set up the cursor and stuff
menu_y_selection=0;
menu_cool_max=15;
menu_cool=0;
menu_scrollbar_pos=0;
menu_cursor_y=0;
menu_yoffset=0; //This is how far offset the surface will draw

//Let's create an array to store things
//Wwe'll add each room we want to be able to visit
counter=0;
destinations=0;
//Don't do the check because of course its discovered the first time you come here!!!
//Tutorial Town
destinations[counter,0]=scr_return_text(520);
destinations[counter,1]=room_Tutorials_1;
destinations[counter,2]=spr_tutorialtown;
if (global.rng==3)
	destinations[counter,2]=spr_tutorialtownalt;
counter+=1;

//EdSpace 1
destinations[counter,0]=scr_return_text(275);
destinations[counter,1]=rm_EdSpace1_1;
destinations[counter,2]=spr_edspace_zone1;
if (global.rng==3)
	destinations[counter,2]=spr_edspace_zone1_alt;
counter+=1;

//EdSpace 2
if (scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.EDSPACE_TWO_COMPLETE))
	{
		destinations[counter,0]=scr_return_text(619);
		destinations[counter,1]=rm_EdSpace2_3;
		destinations[counter,2]=spr_edspace_zone2;
		if (global.rng==3)
			destinations[counter,2]=spr_edspace_zone2_alt;
		counter+=1;
	}


//Set up drawing surface
diarysurface=surface_create(menuwidth,menuheight);
//This is used for lerping with the scroll bar (eventually)
surf_targety=0;

//We also need a seperate surface with the images on
var imagesize=134;
imagesurface=surface_create(imagesize,imagesize);
image_surfx=-imagesize*1.5; //Start at the left of the screen and move right
image_surfy=(display_get_gui_height()-imagesize)*0.5;
image_displaying=noone;