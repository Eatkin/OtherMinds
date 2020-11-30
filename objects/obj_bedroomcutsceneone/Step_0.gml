/// @description checks if the cutscene has finished

if (ds_queue_empty(global.dialoguequeue) and showingcutscene)
	{
		showingcutscene=false;
		with (obj_sage)
			s_b_three=true;
			
		global.softpause=false;
		instance_create_layer(0,0,"Controllers",cam_zoom_controller);
		instance_destroy();
		scr_sageExplode();
	}
else if (showingcutscene==true)
	{
		timer+=1;
		with (obj_camera)
			{
				if state!=CAMERA_MODE.CAM_ZOOM
					{
						state=CAMERA_MODE.CAM_ZOOM;
						following=obj_sage;
					}
			}
		var timerpasstosage=timer;
		with (obj_sage)
			{
				y=ystart+4*dsin(timerpasstosage);
			}
	}