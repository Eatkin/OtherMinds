/// @description double bass break, second room lock in

//Double bass break is 4 bars ie 480 frames
//In which time we should drop 7 blocks (every 60 frames)
//Then double block speed
/*Pushable block end pos=256
in time n it falls n(n+1)*0.25 units
Wolfram Alpha said n~=31 for n(n+1)*0.25=256*/

//Also deactivate the cannons from before
inst_E4CCC4E.activated=false;
inst_6BBC88EF.activated=false;

var player=parent_main_character;
if (player.x==clamp(player.x,672,960) and player.y<288)
	{
		scr_regionlock(480,64,false);
	}