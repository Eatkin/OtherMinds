/// @description
show_debug_message("Room number: "+string(room));
redOrbs+=instance_number(obj_orb_red);
whiteOrbs+=instance_number(obj_orb_white);
greenOrbs+=instance_number(obj_orb_green);
orangeOrbs+=instance_number(obj_orb_orange);
uselessCollectible+=instance_number(obj_uselessCollectible);

if (room==room_last)	{
	show_message("Red: "+string(redOrbs));
	show_message("White: "+string(whiteOrbs));
	show_message("Green: "+string(greenOrbs));
	show_message("Orange: "+string(orangeOrbs));
	show_message("Useless: "+string(uselessCollectible));
	game_end();
}
else
	room_goto_next();