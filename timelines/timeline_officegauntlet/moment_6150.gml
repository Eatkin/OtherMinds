/// @description platform drop

inst_327023E2.activated=true;

//Laser
instance_activate_object(inst_74E88097);
//Saw
instance_activate_object(inst_73EF5C97);

with (obj_gauntlet_popoutspikes)
	{
		if (x==clamp(x,5152,5200) and y==208+16)
			{
				activated=true;
			}
	}