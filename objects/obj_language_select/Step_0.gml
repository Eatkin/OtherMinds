/// @description Menu things
// You can write your code in this editor

var snd=noone;

//Grab inputs
var vinput=0;
var select=0;
if selectedanitem=false
	{
		vinput=global.inputs[1];
		select=global.inputs[4];
		select=max(select,global.inputs[14]); //You can also use the start button
	}
	
//Reset cooldown
if vinput=0
	{
		menucool=0;
	}
	
if sign(vinput)!=0 and menucool=0
	{
		menucool=menucoolmax;
		menu_y-=sign(vinput);
		if menu_y=clamp(menu_y,0,options-1)
			{
				var snd=audio_play_sound(snd_menu_move,0,0);
			}
		else
			{
				var snd=audio_play_sound(snd_menu_no,0,0);
			}
	}
menu_y=clamp(menu_y,0,options-1);

//Update the cursor position
var target_cursory=room_height*0.5-(options-1)*v_spacing*0.5+v_spacing*menu_y-sprite_get_height(spr_menucursor)*0.5; //Ah yes the very obvious formula
var movement=lerp(cursor_y,target_cursory,0.2)-cursor_y;
movement=sign(movement)*max(2,abs(movement));
cursor_y+=movement;
if abs(cursor_y-target_cursory)<=2
	{
		cursor_y=target_cursory;
	}
			
//Update the cursor x too!
var target_cursorx=(room_width-string_width(language[menu_y]))*0.5-8;
var movement=lerp(cursor_x,target_cursorx,0.2)-cursor_x;
movement=sign(movement)*max(2,abs(movement));
cursor_x+=movement;
if abs(cursor_x-target_cursorx)<=2
	{
		cursor_x=target_cursorx;
	}

if select=true
	{
		var snd=audio_play_sound(snd_menu_confirm,0,0);
		selectedanitem=true;
		switch (menu_y)
			{
				case 0:
					{
						global.language=LANGUAGE.ENGLISH;
						break;
					}
				case 1:
					{
						global.language=LANGUAGE.GERMAN;
						scr_load_text_de();
						break;
					}
			}
	}
	
if selectedanitem=true and !instance_exists(obj_transition)
	{
		scr_create_transition(0,TRANSITION.FADE_IN);
	}

if (instance_exists(obj_transition))
	{
		if (obj_transition.transitioncomplete==true)
			{
				var first=controller_global.firstgame;
				//DEBUG
				//first=true;
				//END DEBUG
				var roomToGoto=(first==true) ? rm_firsttime : rm_splash;
				room_goto(roomToGoto);
			}
	}
	
//Final thing - set the gain of the audio!
if snd!=noone
	{
		audio_sound_gain(snd,global.sound_fx_volume*global.sound_fx_on,0);
	}
	
//Set up HUD
var name="Select";
if (menu_y==1)
	{
		name="Auswahl";
	}

scr_HUD_set_tips_buttons(global.kb_b_one);
scr_HUD_set_tips_text(name);