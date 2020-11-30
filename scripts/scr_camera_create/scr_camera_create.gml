//Created 07/07/19
//Last updated 20/08/19

//Initial Camera properties
//This will need to be changed depending on the target aspect ratio
camera=view_camera[0];
thecamwidth=480;
thecamheight=270;
var player=parent_main_character;
if (instance_number(parent_main_character)>1)
	{
		player=global.currentinstance;
	}
camera_set_view_pos(camera,player.x-thecamwidth/2,player.y-thecamheight/2);
camera_set_view_size(camera,thecamwidth,thecamheight);
camera_set_view_speed(camera,0,0);
camera_set_view_border(camera,thecamwidth*0.5,thecamheight*0.4);

//zoom_factor=1;

//Some variables for movement
xspeed=0;
yspeed=0;

//Fix variables for region locked cameras
xfix=0;
yfix=0;
ylocked=false;

//States
state=CAMERA_MODE.CAM_FOLLOW;
if (scr_is_disallowed_room(room)==true)
	{
		state=CAMERA_MODE.CAM_NOCAM;
		camera_set_view_pos(camera,0,0);
	}

//Create the background object
instance_create_layer(0,0,layer,obj_background);

//Instance following
following=noone;

//Effects
shakex=0;
shakey=0;
shakedecay=0.1;