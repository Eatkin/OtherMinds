/// @description

//Set alarm, but make sure it doesn't trigger multiple times
if (keyboard_check_pressed(vk_anykey) and !instance_exists(obj_transition))
	alarm[0]=min(1,alarm[0]);
	
if (transCreated)
	if (!instance_exists(obj_transition) or obj_transition.transitioncomplete)	{
		var first=controller_global.firstgame;
		//DEBUG
		//first=true;
		//END DEBUG
		var roomToGoto=(first==true) ? rm_firsttime : rm_main_menu;
		room_goto(roomToGoto);
	}