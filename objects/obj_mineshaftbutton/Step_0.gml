/// @description

// Inherit the parent event
event_inherited();

if active=1
	{
		active=0;
		scr_queue_dialogue_box(scr_return_text(328));
		scr_play_sound(snd_menu_slider,0,0);
		obj_dialogue.x=x;
		obj_dialogue.y=y;
	}