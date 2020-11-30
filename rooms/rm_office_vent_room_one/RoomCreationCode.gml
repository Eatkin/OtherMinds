if (scr_event_check_complete(global.officeevents,OFFICEEVENTS.VENTROOM1_SNAKES)==true)
	{
		with (obj_snakecharacter)
			{
				instance_destroy();
			}
		if (scr_event_check_complete(global.officeevents,OFFICEEVENTS.VENTROOM1_CARD)==false)
			{
				instance_create_layer(880,624,"objects",obj_keycard_D_shard1);
			}
	}