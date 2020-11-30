/// @description

// Inherit the parent event
event_inherited();

//This is temp as no coin exists in the game at the moment
if (active==true)
	{
		active=false;
		scr_queue_dialogue_box(scr_return_text(618));
		obj_dialogue.x=x;
		obj_dialogue.y=y;
	}