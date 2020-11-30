/// @description (BEAT 60) spikes pop out whilst running away

//Good way to activate a bunch at once

with (obj_gauntlet_popoutspikes)
	{
		if (x==clamp(x,992,1136) and y==48+16)
			{
				activated=true;
			}
	}