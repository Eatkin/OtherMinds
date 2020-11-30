/// @description

if (surface_exists(difficultySurface))
	{
		surface_free(difficultySurface);
	}
	
//Clear the notification queue
ds_queue_clear(global.notificationqueue);