/// @description spikes retraxt,LHS laser warning, L saw active

with (inst_2F88A804)
	{
		staticTimer=staticTimerMax;
		tvSprite=spr_laserScreen;
	}
	
inst_6259C516.maxspeed=6;
inst_6259C516.xbound=room_width*2;

with (obj_gauntlet_popoutspikes)
	{
	 if (x==clamp(x,3104,3552) and y==336)
		{
			activated=false;
		}
	}
