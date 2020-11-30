//Load the level given in the argument

var target=argument0;
global.currentprofile=4;		//This is an invalid save game so no data will get overwritten
								//i.e. this is a 'no save' save

//Create an invisible door because I can't be bothered to program this properly
var door=instance_create_layer(0,0,layer,obj_door);
door.destination=target
door.visible=false;
door.active=true;

global.currentinstance=instance_create_layer(room_width*0.5,room_height*0.4,"players",obj_Ed);