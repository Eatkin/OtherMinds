//Go to attract mode

//Create an invisible door because I can't be bothered to program this properly
var door=instance_create_layer(0,0,layer,obj_door);
door.destination=rm_loadAttract
door.visible=false;
door.active=true;

var cam=view_camera[0];
var camy=camera_get_view_y(cam);

var edYTarget=camy-room_height*0.1;
global.currentinstance=instance_create_layer(room_width*0.5,edYTarget,"players",obj_Ed);