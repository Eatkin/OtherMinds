/// @description

rhythmBlocks=true;

instanceToCreate=obj_musicControlsEdSpace1;

if (room==rm_Ochre_Rhythm)	{
	instanceToCreate=obj_musicControlsOchre;
	rhythmBlocks=false;
}
else if (room==rm_whiteRhythm)	{
	instanceToCreate=obj_musicControlsWhiteArea;
	rhythmBlocks=false;
}
else if (room==rm_EdSpace2_Rhythm)	{
	instanceToCreate=obj_musicControlsEdSpace2;
	rhythmBlocks=false;
}


//Setup
switch (room)	{
	case rm_EdSpace1_Rhythm:
		//Setup
		instance_deactivate_object(inst_66B2EB6F);
		instance_deactivate_object(inst_6EA2C56D);
		instance_deactivate_object(inst_4C16BB78);
		instance_deactivate_object(inst_4C16BB78);
		//Deactivate the cannons that aren't over to the very right of the level
		with (obj_cannon)
			if (x<1960 and y<704)
				instance_deactivate_object(id);
				
		instance_deactivate_object(obj_saw);
		break;
}