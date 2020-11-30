/// @description

var characterInPos=false
if (room==rm_office_vent_room_one and parent_main_character.x<x)
	characterInPos=true;
else if (room==rm_office_vent_room_two and parent_main_character.x>x)
	characterInPos=true;

if (!instance_exists(obj_transition)  and !global.hardpause and characterInPos)
	{
		//create return home from menu dialogue
		instance_create_layer(0,0,layer,obj_ventroomCutscene);
		global.officeevents=scr_event_set_complete(global.officeevents,OFFICEEVENTS.VENTROOMCUTSCENE);
		instance_destroy();
	}