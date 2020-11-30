//Created 11/04/20
//Last updated 11/04/20

//This check the disallowed rooms list and returns if argument0 is on it
var _room=argument0;

var index=ds_list_find_index(global.disallowedrooms,_room);

if (index==-1)
	{
		return false;
	}
	
return true;