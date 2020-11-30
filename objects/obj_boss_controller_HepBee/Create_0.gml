/// @description

state=BOSS_STATE.INACTIVE;

//If boss has been defeated, kill them!!
//And spawn the platforms and things
if (scr_event_check_complete(global.ochre_events,OCHRE_EVENTS.HEP_BEE_DEFEATED)==true)
	{
		var xspawn=-96;
		var yspacing=64;
		var ypos=1456; //So platforms should be 64+yspacing*i
		for (var i=0; i<12; i+=1)
			{
				platform[i]=instance_create_layer(xspawn,ypos-yspacing*i,"objects",obj_honeyplatform);
				platform[i].minx=-97;
			}
		state=BOSS_STATE.DEFEATED;
	}
else
	{
		//Create the 3 platforms at the base
		//These conveniently have an inbuilt destroyed timer I can use to drop them
		//But I should modify that so they don't get destroyed, just stop off screen and get lerped back into pos later
		var yspawn=1520;
		var xspawn=80;
		var xspacing=4.5*32;
		platformNumber=3;
		if (scr_return_difficulty()<=DIFFICULTY.EASY)
			{
				platformNumber=5;
				xspacing*=0.5;
			}
		for (var i=0; i<platformNumber; i+=1)
			{
				platform[i]=instance_create_layer(xspawn+xspacing*i,yspawn,"objects",obj_honeyplatform);
			}
		for (var i=platformNumber; i<12; i+=1)
			{
				platform[i]=noone;
			}
	}

//Create the deadly honey. This is just below the level by the way, Future Ed.
honey=instance_create_layer(0,1632,"Lighting",obj_deadlyhoney);

//Also need to create a block to stand on to prevent the player falling too far below the level
//This is created at the base of the 'hive' and will be pegged to the camera
baseblock=instance_create_layer(0,1537,"blocks",obj_block);
scr_object_resize(baseblock,480,16);
if (scr_event_check_complete(global.ochre_events,OCHRE_EVENTS.HEP_BEE_DEFEATED)==true)
	{
		instance_destroy(baseblock);
	}

//Some variables to control various behaviours
honeyrising=false;

risingsound=noone;