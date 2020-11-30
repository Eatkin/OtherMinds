/// @description RHS triplets

with (obj_gauntlet_popoutspikes)
	{
		if (x==clamp(x,3536,3552) and y==336+16)
			{
				activated=true;
			}
	}
	
with (inst_29235B7E)
	{
		staticTimer=staticTimerMax;
		tvSprite=spr_spikesScreen;
	}