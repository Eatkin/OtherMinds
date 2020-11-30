/// @description

// Inherit the parent event
event_inherited();

if active=true
	{
		scr_queue_dialogue_box(scr_return_text(340));
		obj_dialogue.x=x+sprite_width*0.5;
		obj_dialogue.y=y+sprite_height*0.5;
		active=false;
	}