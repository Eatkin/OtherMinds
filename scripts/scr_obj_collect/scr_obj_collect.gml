//Created 30/08/19
//Last updated 30/08/19

//This handles the player collecting an object
//Changes their state and sets their holding statusoka. What the hell is a statusoka? - Future Ed
var player=parent_main_character;

//Don't pick things up when not being controlled because it causes horrifying bugs
if (player.id!=global.currentinstance)
	exit;
	
player.state=PlayerState.holding;
player.holding=object_index;
//Update this so it zooms into the right position
obj_speechbubble.x=player.x;
obj_speechbubble.y=player.y;

//Create the jingle player
instance_create_layer(x,y,layer,obj_collect_sound);

//Don't forget to destroy the collected item dumb dumb
instance_destroy();

//Now update the map enhancer
scr_mapenhancer_update();