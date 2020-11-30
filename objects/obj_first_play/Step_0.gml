/// @description Check whether to continue
// You can write your code in this editor

var _continue=false;

if (global.input==true)
	{
		if (keyboard_check_pressed(vk_anykey))
			{
				_continue=true;
			}
	}
else
	{
		if (scr_detect_gamepad_input()!=false)
			{
				_continue=true;
			}
	}
	
if (alarm[0]<0 or controller_global.previous_room==rm_main_menu)
	{
		if (_continue=true and !instance_exists(obj_transition))
			{
				if (show_transition==true)
					{
						scr_create_transition(0,TRANSITION.FADE_IN);
					}
				else
					{
						room_goto(rm_main_menu);
					}
			}
	}

if (instance_exists(obj_transition))
	{
		if (obj_transition.transitioncomplete==true)
			{
				room_goto(rm_main_menu);
			}
	}
	
if (alarm[0]<0)
	{
		pressanykeyalpha=lerp(pressanykeyalpha,1,0.05);
	}