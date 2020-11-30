/// @description checks if the cutscene has finished

if (ds_queue_empty(global.dialoguequeue) and showingcutscene)
	{
		showingcutscene=false;
		with (obj_sage)
			s_b_three=true;
			
		with (global.currentinstance)
			scr_todo_discover(18);

		global.softpause=false;
		//Discover the event
		instance_destroy();
		scr_sageExplode();
		
		//Reinitialise the bed so it doesn't take us back to EdSpace 2 (lol worst code)
		with (obj_bed)
			event_perform(ev_create,0);
	}
else if (showingcutscene)
	{
		//Slide to the right
		var _t=timer;
		if (_t<16)
			{
				with (obj_sage)
					{
						s_hinput=1;
						if (_t<10)
							s_vinput=1;
					}
			}
		timer+=1;
		
		with (obj_camera)
			if state!=CAMERA_MODE.CAM_ZOOM
				{
					state=CAMERA_MODE.CAM_ZOOM;
					following=obj_sage;
				}
			
		with (obj_sage)
			if (_t>=32)
				{ 
					if (_t==32)
						ystart=y;
					y=ystart+4*dsin(_t);
				}
	}