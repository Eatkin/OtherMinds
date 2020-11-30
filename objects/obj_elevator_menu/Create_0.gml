/// @description

//Hard pause to prevent movement, pause audio
//Could soft pause but that's disables the help bar in a genius move by me, well done
global.softpause=true;

//Fade background music to a low level
with (obj_music)
	{
		if nowplaying!=noone
			{
				audio_sound_gain(nowplaying,0.1*global.music_volume*global.music_on,500);
			}
	}
	
moveenabled=0;
changingrooms=false;
movedir=1;
var snd=audio_play_sound(snd_menu_shift,0,0);
audio_sound_gain(snd,global.sound_fx_volume*global.sound_fx_on,0);
menu_x=display_get_gui_width()*1.25; //Start at the RIGHT of the screen and lerp left - we overshoot to allow a bit of a smoother transition
menu_y=display_get_gui_height()*0.125;
menuwidth=sprite_get_width(spr_elevator_pad);
menuheight=sprite_get_height(spr_elevator_pad);

//Set up the cursor and stuff
menu_y_selection=0;
menu_cool_max=15;
menu_cool=0;
menu_scrollbar_pos=0;
menu_cursor_y=0;
menu_yoffset=0; //This is how far offset the surface will draw

//Let's create an array to store things
//Wwe'll add each room we want to be able to visit
//This is just rooms because we are going to draw elevator buttons on the surface
destinations[0]=rm_office_reception;
destinations[1]=rm_office_floor_one;
destinations[2]=rm_office_floor_two;
destinations[3]=rm_office_new_ds_office;

counter=array_length_1d(destinations);

//Find menu_y and set to current selection
for (var i=0; i<counter; i+=1)
	{
		if (destinations[i]==room)
			{
				menu_y_selection=i;
				break;
			}
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