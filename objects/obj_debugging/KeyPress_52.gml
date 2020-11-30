/// @description	Room change
// You can write your code in this editor

if (global.debugging==false or global.maincharacter==obj_Charlotte)
	{
		exit;
	}

var last=room_last;
var first=room_first;
var _room=get_integer("Go to room "+string(first)+"-"+string(last)+". Current room ID - "+string(room),0);
room_goto(_room);

if (global.attract==true)
	{
		global.rng=irandom(3);		//Set this BEFORE RANDOMISING AND SETTING SEED
		randomise();
		random_set_seed(11223344);
	}