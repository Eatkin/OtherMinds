/// @description spikes eject/first blocks falling

//Drop first two blocks
instance_activate_object(inst_2BC4A946);
instance_activate_object(inst_44BB2444);

with (obj_gauntlet_popoutspikes)
	{
		if (x==clamp(x,3824,3936) and y==80+16)
			{
				activated=true;
			}
	}
	
//Drop shit - this activates a stack of push blocks
instance_activate_region(3792,-192,32,160,true);