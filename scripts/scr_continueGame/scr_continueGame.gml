//Just load the previously opened game

global.gametoload=global.currentprofile;

//Create an invisible door because I can't be bothered to program this properly
var door=instance_create_layer(0,0,layer,obj_door);
door.destination=rm_loadGame;
door.visible=false;
door.active=true;

global.currentinstance=instance_create_layer(room_width*0.5,room_height*0.4,"players",obj_Ed);