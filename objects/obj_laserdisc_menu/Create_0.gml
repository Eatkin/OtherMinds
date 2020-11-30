/// @description

//Hard pause to prevent movement, pause audio
//Could soft pause but that's disables the help bar in a genius move by me, well done
global.softpause=true;

global.globalevents=scr_event_set_complete(global.globalevents,EVENTS_GLOBAL.TIMETRIALSACTIVE);

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

//Find out laserdisc info
//EdSpace 1 challenge
if (scr_inventory_check(obj_laser_diskvol1))
	{
		destinations[counter,0]=scr_return_text(195);
		destinations[counter,1]=rm_EdSpace_z1_challenge;
		destinations[counter,2]=spr_edspace_z1_challenge;
		if (global.rng==2)
			{
				destinations[counter,2]=spr_edspace_z1_challenge_alt;
			}
		//Find the row in the global.timetrials grid
		for (var i=0; i<ds_grid_height(global.besttimes); i+=1)
			{
				if (room_get_name(destinations[counter,1])==ds_grid_get(global.besttimes,BESTTIMES.ROOMNAME,i))
					{
						break;
					}
			}
		var targettime=ds_grid_get(global.besttimes,BESTTIMES.TARGETTIME,i);
		var besttime=ds_grid_get(global.besttimes,BESTTIMES.BESTTIME,i);
		var devtime=ds_grid_get(global.besttimes,BESTTIMES.DEVTIME,i);
		destinations[counter,3]=scr_timetostring(targettime);
		destinations[counter,4]=scr_timetostring(besttime);
		destinations[counter,5]=scr_timetostring(devtime);
		destinations[counter,6]=scr_event_check_complete(global.timetrials,TIMETRIALS.EDSPACE_Z1_TRIAL);
		counter+=1;
	}
	
//Ochre challenge
if (scr_inventory_check(obj_laser_diskvol2))
	{
		destinations[counter,0]=scr_return_text(409);
		destinations[counter,1]=rm_OchreHill_challenge;
		destinations[counter,2]=spr_ochre_challenge;
		if (global.rng==2)
			{
				destinations[counter,2]=spr_ochre_challenge_alt;
			}
		//Find the row in the global.timetrials grid
		for (var i=0; i<ds_grid_height(global.besttimes); i+=1)
			{
				if (room_get_name(destinations[counter,1])==ds_grid_get(global.besttimes,BESTTIMES.ROOMNAME,i))
					{
						break;
					}
			}
		var targettime=ds_grid_get(global.besttimes,BESTTIMES.TARGETTIME,i);
		var besttime=ds_grid_get(global.besttimes,BESTTIMES.BESTTIME,i);
		var devtime=ds_grid_get(global.besttimes,BESTTIMES.DEVTIME,i);
		destinations[counter,3]=scr_timetostring(targettime);
		destinations[counter,4]=scr_timetostring(besttime);
		destinations[counter,5]=scr_timetostring(devtime);
		destinations[counter,6]=scr_event_check_complete(global.timetrials,TIMETRIALS.OCHRE_TRIAL);
		counter+=1;
	}
	
//EdSpace z2 challenge
if (scr_inventory_check(obj_laser_diskvol3))
	{
		destinations[counter,0]=scr_return_text(650);
		destinations[counter,1]=rm_EdSpace_z2_challenge;
		destinations[counter,2]=spr_edspace_z2_challenge;
		if (global.rng==2)
			destinations[counter,2]=spr_edspace_z1_challenge_alt;
			
		//Find the row in the global.timetrials grid
		for (var i=0; i<ds_grid_height(global.besttimes); i+=1)
			{
				if (room_get_name(destinations[counter,1])==ds_grid_get(global.besttimes,BESTTIMES.ROOMNAME,i))
					{
						break;
					}
			}
		var targettime=ds_grid_get(global.besttimes,BESTTIMES.TARGETTIME,i);
		var besttime=ds_grid_get(global.besttimes,BESTTIMES.BESTTIME,i);
		var devtime=ds_grid_get(global.besttimes,BESTTIMES.DEVTIME,i);
		destinations[counter,3]=scr_timetostring(targettime);
		destinations[counter,4]=scr_timetostring(besttime);
		destinations[counter,5]=scr_timetostring(devtime);
		destinations[counter,6]=scr_event_check_complete(global.timetrials,TIMETRIALS.EDSPACE_Z2_TRIAL);
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