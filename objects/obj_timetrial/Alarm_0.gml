/// @description
var player=parent_main_character;
var leveltransition=instance_create_layer(player.x,player.y,"objects",obj_dooractivateontouch);
leveltransition.destination=rm_inside_outhouse;