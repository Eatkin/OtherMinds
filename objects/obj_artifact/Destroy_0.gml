/// @description

scr_todo_discover(24);

if (scr_inventory_check_quantity(obj_artifact)>=7)
	scr_todo_complete(24);

//Events for lights in mysterious room
var _exit=false;
var _event=0;
switch (room)	{
	case rm_EdSpace1_Rhythm:
		_event=0;
		break;
	case rm_Ochre_Rhythm:
		_event=1;
		break;
	//This doesn't exist yet
	case rm_EdSpace2_Rhythm:
		_event=2;
		break;
	case rm_whiteRhythm:
		_event=3;
		break;
	
	default:
		_exit=true;
		break;
}

if (_exit)
	exit;
	
_event=power(2,_event);

global.mysteriousRoomEvents=scr_event_set_complete(global.mysteriousRoomEvents,_event);