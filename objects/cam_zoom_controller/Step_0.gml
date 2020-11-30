/// @description

//If we're not zoomed in and a transition has just finished, we zoom in
if zoomon=false and !instance_exists(obj_transition)
	{
		zoomon=true;
		with (obj_camera)
			{
				state=CAMERA_MODE.CAM_ZOOM;
				following=global.currentinstance;
			}
	}

//Make sure the camera is always following the current instance
//(EXCEPT WHEN FOLLOWING PEOPLE YOU'RE TALKING TO, DUMBASS)
var follow=obj_camera.following;
var dialogueoff=ds_queue_empty(global.dialoguequeue);
if (dialogueoff==true and follow!=global.currentinstance and zoomon==true)
	{
		obj_camera.following=global.currentinstance;
	}
	
if zoomon=true
	{
		var camstate=obj_camera.state;
		if camstate=CAMERA_MODE.CAM_FOLLOW
			{
				obj_camera.state=CAMERA_MODE.CAM_ZOOM;
			}
	}

//If a transition is created and we are zoomed in, zoom out (except this doesn't work for some strange reason)
if instance_exists(obj_transition) and zoomon=true
	{
		zoomon=false;
		with (obj_camera)
			{
				following=noone;
			}
	}