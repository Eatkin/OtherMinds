if (scr_event_check_complete(global.officeevents,OFFICEEVENTS.VENTROOM2_SNAKES)==true)
	{
		with (obj_snakecharacter)
			{
				instance_destroy();
			}
		if (scr_event_check_complete(global.officeevents,OFFICEEVENTS.VENTROOM2_CARD)==false)
			{
				instance_create_layer(592,640,"objects",obj_keycard_D_shard2);
			}
	}