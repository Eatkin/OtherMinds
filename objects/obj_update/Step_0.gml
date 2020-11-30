/// @description

switch (state)
	{
		case UPDATESTATE.CHECKING:
			{
				
				break;
			}
		case UPDATESTATE.FAILED:
			{
				room_goto(destination);
				break;
			}
		case UPDATESTATE.NOUPDATE:
			{
				room_goto(destination);
				break;
			}
		case UPDATESTATE.UPDATEFOUND:
			{
				texttodraw="An update was found";
				break;
			}
	}

if (state!=UPDATESTATE.UPDATEFOUND)
	{
		exit;
	}

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
var target_cursory=room_height*0.5-options*v_spacing*0.5+v_spacing*menu_y-sprite_get_height(spr_menucursor)*0.5; //Ah yes the very obvious formula
var movement=lerp(cursor_y,target_cursory,0.2)-cursor_y;
movement=sign(movement)*max(2,abs(movement));
cursor_y+=movement;
if abs(cursor_y-target_cursory)<=2
	{
		cursor_y=target_cursory;
	}
			
//Update the cursor x too!
var target_cursorx=(room_width-string_width(option[menu_y]))*0.5-8;
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
		switch (menu_y)
			{
				case 0:
					{
						selectedanitem=true;
						break;
					}
				case 1:
					{
						url_open(changelogurl);
						break;
					}
				case 2:
					{
						url_open(downloadlink);
						break;
					}
			}
	}
	
if (selectedanitem=true and !instance_exists(obj_transition))
	{
		scr_create_transition(0,TRANSITION.FADE_IN);
	}

if (instance_exists(obj_transition))
	{
		if (obj_transition.transitioncomplete==true)
			{
				room_goto(destination);
			}
	}
	
//Final thing - set the gain of the audio!
if snd!=noone
	{
		audio_sound_gain(snd,global.sound_fx_volume*global.sound_fx_on,0);
	}