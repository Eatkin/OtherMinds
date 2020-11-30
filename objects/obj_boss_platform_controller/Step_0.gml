/// @description

if global.hardpause=true or instance_exists(obj_transition)
	{
		exit;
	}

//Let's set the platform speeds depending on how long we've been active
if activated=false
	{
		currentspeed=lerp(currentspeed,0,0.1);
		if abs(currentspeed)<0.1
			{
				currentspeed=0;
			}
	}
else
	{
		currentspeed=lerp(currentspeed,platspeed,0.1);
		if currentspeed>abs(platspeed-0.1)
			{
				currentspeed=platspeed;
			}
	}
//Save this to pass to the platforms
var _speed=currentspeed;

//Start creating platforms
var num=instance_number(obj_platform_bosscontrolled);
//Min 4, max 5
var spawnblock=0;
var spawnx=830;
if (global.rng==1)
	{
		spawnx=320;
	}
//Check if there's a bottom or middle platform available and make one available if nots
var x1=384;
var x2=736;
if collision_rectangle(x1,620,x2,700,obj_platform_bosscontrolled,0,true)
	{
		var spawny=choose(576,624,672);
	}
else
	{
		var spawny=choose(624,672);
	}
				
//Spawn a platform if there's less than 4, give a 1/60 chance if there's up to 5
var maxplatforms=5;
if (scr_return_difficulty()>=DIFFICULTY.HARD)
	{
		maxplatforms-=1;
	}
if (scr_return_difficulty()<=DIFFICULTY.EASY)
	{
		maxplatforms+=1;
	}
if (num<4)
	{
		spawnblock=1;
	}
else if num=clamp(num,0,maxplatforms)
	{
		var roll=irandom(60);
		if roll=1
			{
				spawnblock=1;
			}
	}
//Do a check to see if a block will overlap in the vertical plane
var collcheck=spawnx+32;
if (global.rng==1)
	{
		collcheck+=sprite_get_width(spr_darktiles_short)-64;
	}
if collision_line(collcheck,560,collcheck,704,obj_platform_bosscontrolled,false,true)
	{
		spawnblock=0;
	}

if obj_boss_controller.state=BOSS_STATE.DEFEATED
	{
		spawnblock=0;
	}
//After all that we only spawn a block if the button is currently active
if spawnblock=1 and activated=true
	{
		//Leave at least a 128 px gap between platform spawns
		var newblock=instance_create_layer(spawnx,spawny,"objects",obj_platform_bosscontrolled);
		//Delete if there's already something there
		with (newblock)
			{
				var placecheck=x-64-_speed;
				if (global.rng==1)
					{
						//This is the boss platform sprite
						placecheck=x+sprite_get_width(spr_darktiles_short)+64+_speed;
					}
				if place_meeting(x,y,obj_platform_bosscontrolled) or place_meeting(placecheck,y,obj_platform_bosscontrolled)
					{
						instance_destroy();
					}
			}
	}
	

//Now update the speeds
if num>0
	{
		with (obj_platform_bosscontrolled)
			{
				xspeed=_speed;
			}
	}