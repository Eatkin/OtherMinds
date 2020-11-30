/// @description checks if the cutscene has finished

if (ds_queue_empty(global.dialoguequeue) and showingcutscene)	{
		showingcutscene=false;			
		global.softpause=false
		instance_destroy();
		scr_sageExplode();
}
else if (showingcutscene)	{
		//Slide to the LEFT
		var _t=timer;
		if (_t<16)
			with (obj_sage)	{
				s_hinput=-1;
				if (_t<10)
					s_vinput=1;
			}
			
		timer+=1;
		
		with (obj_camera)
			if (state!=CAMERA_MODE.CAM_ZOOM)	{
				state=CAMERA_MODE.CAM_ZOOM;
				following=obj_sage;
			}
					
		with (obj_sage)
			if (_t>=32)	{ 
				if (_t==32)
					ystart=y;
				var ytarg=ystart+4*dsin(_t);
				if (!place_meeting(x,ytarg,obj_solid))
					y=ytarg;
			}
	}