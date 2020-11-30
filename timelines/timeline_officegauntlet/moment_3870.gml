/// @description triplets begin, also destroy some spikes

with (obj_gauntlet_popoutspikes)
	{
		if (x==clamp(x,3296,3360) and y==336+16)
			{
				instance_destroy();
			}
		if (x==clamp(x,3104,3120) and y==336+16)
			{
				activated=true;
			}
	}
	
with (inst_2F88A804)
	{
		staticTimer=staticTimerMax;
		tvSprite=spr_spikesScreen;
	}