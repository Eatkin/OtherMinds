if (scr_event_check_complete(global.officeevents,OFFICEEVENTS.VENTROOM3_SNAKES)==true)
	{
		with (obj_snakecharacter)
			{
				instance_destroy();
			}
		if (scr_event_check_complete(global.officeevents,OFFICEEVENTS.VENTROOM3_CARD)==false)
			{
				instance_create_layer(992,1232,"objects",obj_keycard_D_shard3);
			}
	}