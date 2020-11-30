/// @description room lock-in (2nd check)

var player=parent_main_character;

//2nd check but make sure it ISN'T ALREADY LOCKED!!
if (!instance_exists(block[0]) and player.x>=3088)
	{
		scr_regionlock(3088,112,true);
	}

//Right laser warning
with (inst_29235B7E)
	{
		staticTimer=staticTimerMax;
		tvSprite=spr_laserScreen;
	}
	
//Entryway spikes
inst_1828D373.activated=true;