/// @description

if (ds_queue_empty(global.dialoguequeue))
	{
		instance_create_layer(x,y,layer,obj_calanderEventsOneCompleteCutscene);
		instance_destroy();
	}