/// @description beat 64, piano gliss - floor drop

inst_6119B4D8.activated=true;
/// @description (BEAT 62) spikes pop out whilst running away

//Good way to activate a bunch at once

with (obj_gauntlet_popoutspikes)
	{
		if (x==clamp(x,1536,1680) and y==48+16)
			{
				activated=true;
			}
	}