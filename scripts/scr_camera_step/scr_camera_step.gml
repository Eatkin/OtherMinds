//Create 07/07/19
//Last updated 14/07/19

if global.hardpause==true
	{
		//scr_camera_pause(); //Uncomment this and the next for pause zoom, but it sucks so probably don't use it
		exit;
	}
/*
if (state!=CAMERA_MODE.CAM_ZOOM)
	{
		var camwidth=camera_get_view_width(camera);
		var camheight=camera_get_view_height(camera);
		//Lerp the zoom
		var newcamw=lerp(camwidth,thecamwidth,0.1);
		var newcamh=lerp(camheight,thecamheight,0.1);
		if abs(camwidth-thecamwidth)<1
			{
				newcamw=thecamwidth;
			}
		if abs(camheight-thecamheight)<1
			{
				newcamh=thecamheight;
			}
		camera_set_view_size(camera,newcamw,newcamh);
	}*/

//We also have CAM_NOCAM which gives the user full manual comera control
switch (state)
	{
		case CAMERA_MODE.CAM_FOLLOW:
			{
				scr_camera_follow();
				break;
			}
		case CAMERA_MODE.CAM_SCROLLDOWN:
			{
				scr_camera_scrolldown();
				break;
			}
		case CAMERA_MODE.CAM_SCROLLUP:
			{
				scr_camera_scrollup();
				break;
			}
		case CAMERA_MODE.CAM_ZOOM:
			{
				scr_camera_zoom(0.5);
				break;
			}
		case CAMERA_MODE.CAM_ZOOMOUT:
			{
				scr_camera_zoom(2);
				break;
			}
		case CAMERA_MODE.CAM_FIXED:
			{
				scr_camera_fixed();
				break;
			}
	}

//Lerp the screen shake
shakex=lerp(shakex,0,shakedecay);
shakey=lerp(shakey,0,shakedecay);
if shakex<0.1
    {
        shakex=0;
    }
if shakey<0.1
    {
        shakey=0;
    }