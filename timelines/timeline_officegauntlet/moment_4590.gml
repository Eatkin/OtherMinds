/// @description checkpoint 2

//Toggle block, but if check point active it's already toggled
if (global.checkpoint[0]!=inst_694D051F)
	{
		inst_76F7776D.activated=true;
		//Let's also make sure the player hits the checkpoint by some dumb shit
		with (inst_694D051F)
			{
				x=3792;
			}
	}
	
//Deactivate all now-unused pushables
/*
with (parent_push)
	if (x<3792)
		instance_deactivate_object(id);*/