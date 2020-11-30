if scr_event_check_complete(global.overworld_events,OVERWORLD_EVENTS.PUZZLECAVECOMPLETE)=true
	{
		with (parent_push)
			{
				instance_destroy();
			}
	}
else
	{
		instance_deactivate_object(inst_63ABEAE2);
		instance_deactivate_object(inst_2430B276);
	}