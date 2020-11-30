/// @description laser and saw activate

//Laser
instance_activate_object(inst_74E88097);
//Saw
instance_activate_object(inst_73EF5C97);

//Deactivate all now-unused pushables
with (parent_push)
	if (x<5216)
		instance_deactivate_object(id);
		
//Deactivate the two platforms above this area
instance_deactivate_object(inst_46B844F7);
instance_deactivate_object(inst_327023E2);