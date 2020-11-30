/// @description (BEAT 61) spikes pop out whilst running away

//Good way to activate a bunch at once

with (obj_gauntlet_popoutspikes)
	{
		if (x==clamp(x,1248,1392) and y==48+16)
			{
				activated=true;
			}
	}