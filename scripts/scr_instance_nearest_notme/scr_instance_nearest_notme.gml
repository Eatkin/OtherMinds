//Created 28/10/19
//Last updated 28/10/19

//The dumbest script ever

var _x = x;
x -= 10000000;
var _inst = instance_nearest(_x, y, argument0);
x = _x;


if _inst != id && _inst != noone
	{
		return _inst;
	}
	
return noone;