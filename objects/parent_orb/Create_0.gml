/// @description Destroy if already collected
// You can write your code in this editor
event_inherited();

//Set an alarm to determine when to make a random movement
alarm[0]=irandom(6)+2;

//This is referenced from Ed's script because he can phase through items at terminal velocity
collected=0;


//Here I'll have some code that checks a DS map to see if the inparticular ID has already been taken
//NOT IN ATTRACT MODE THOUGH - there may be data from save games loaded and these orbs move randomly
//That would fuck up the rng calls
if (!global.attract)
	scr_itemmap_check();

//Colour ref for particles
switch (object_index)
	{
		case obj_orb_red:
			particleColour=c_red;
			break;
		case obj_orb_green:
			particleColour=c_lime;
			break;
		case obj_orb_orange:
			particleColour=c_orange;
			break;
		default:
			particleColour=c_white;
			break;
	}