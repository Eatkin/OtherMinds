/// @description

if (global.hardpause)
	exit;
	

var _bossState=obj_drdeath_edspace2boss.bossState;
//Don't work if we're not in boss state
if (activated and _bossState==BOSS_STATE.PHASEFOUR)
	{
		
		//Destroy saws
		if (instance_exists(obj_saw))
			with (obj_saw)
				if (dir=-1 and x<xstart)
					instance_destroy();
		
		//We check which button has been pressed
		//We do this by checking the image_index because I am terrible at programming
		if (button[0].image_index==1 and !sawSpawned and instance_number(obj_saw)==0)
			{
				sawSpawned=true;
				var saw=instance_create_layer(4048,288,"objects",obj_saw);
				saw.xbound*=2;
			}
		else if (button[1].image_index==1 and !bombsOn)
			{
				bombsOn=true;
				if (instance_number(obj_bomb_block)<6)		//Think there's already 1-3 somewhere else in the level
					{
						var bomb=instance_create_layer(4196,176,"objects",obj_bomb_block);
						bomb.exploding=true;
						bomb=instance_create_layer(4320,176,"objects",obj_bomb_block);
						bomb.exploding=true;
						bomb=instance_create_layer(4416,176,"objects",obj_bomb_block);
						bomb.exploding=true;
					}
			}
			
		if (button[0].image_index!=1)
			sawSpawned=false;
		if (button[1].image_index!=1)
			bombsOn=false;
	}
if (_bossState==BOSS_STATE.DEFEATED)
	{
		if (instance_exists(obj_saw))
			with (obj_saw)
				x=lerp(x,-room_width*0.5,0.01);
	}