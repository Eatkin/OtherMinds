/// @description

// Inherit the parent event
event_inherited();

if (active==true)
	{
		scr_queue_dialogue_box(scr_return_text(562));
		obj_dialogue.x=x;
		obj_dialogue.y=y;
		active=false;
	}