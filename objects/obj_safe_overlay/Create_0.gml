/// @description

with (global.currentinstance)
	{
		scr_todo_discover(4);
	}

//Tumbler information
tumbler[0]=0;
tumbler[1]=0;
tumbler[2]=0;
tumbler[3]=0;
tumblerydraw[0]=-16;
tumblerydraw[1]=-16;
tumblerydraw[2]=-16;
tumblerydraw[3]=-16;
tumblercooldownmax=15;
tumblercooldown=0;
tumblerselected=0;

//Surface information
numberssurface=noone;
numberssprite=spr_safetumblernumbers;
surf_height=sprite_get_height(numberssprite);
surf_width=sprite_get_width(numberssprite);

//The information about what coordinates the surfaces draw from
surfy[0]=16;
surfy[1]=16;
surfy[2]=16;
surfy[3]=16;

//Loading in/out information
fadingin=true;
fadingout=false;
safeunlocked=false;

//Rectangle information
backgroundalpha=0;
backgroundalphamax=1;

//Pause and gui info
global.softpause=true;
guiwidth=display_get_gui_width();
guiheight=display_get_gui_height();

//Sounds
sound_menuopen=snd_menu_shift;
sound_tumblershift=snd_menu_slider;
sound_safeunlock=snd_door_unlock;
sound_changetumbler=snd_menu_move;

with (obj_music)
	{
		if nowplaying!=noone
			{
				audio_sound_gain(nowplaying,0.1*global.music_volume*global.music_on,500);
			}
	}

var snd=audio_play_sound(sound_menuopen,0,false);
audio_sound_gain(snd,global.sound_fx_volume*global.sound_fx_on,0);