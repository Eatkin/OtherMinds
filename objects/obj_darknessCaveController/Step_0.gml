/// @description calculate darkness

var factor=parent_main_character.x/room_width;	//between 0 and 1

obj_darkness.darknessmultiplyer=0.8-0.2*factor;		//Between 0.6 and 0.8