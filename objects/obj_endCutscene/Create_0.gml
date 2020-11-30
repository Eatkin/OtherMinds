/// @description set up cutscene

showingcutscene=true;
global.softpause=true
var player=parent_main_character;
player.directionfacing=1;		//Face right, because looks stupid otherwise
var sage=instance_create_layer(player.x,player.y,"players",obj_sage); //Ed's co-ords
//This is to set upthe camera correctly but think it gets overwritten at room start
obj_speechbubble.x=sage.x;
obj_speechbubble.y=sage.y;
with (sage)	{
	var text;
	for (var i=0; i<19; i+=1)
		text[i]=scr_return_text(787+i);
	for (var i=0; i<array_length_1d(text);i+=1)
		scr_queue_dialogue_box(text[i]);
	}
	
timer=0;

//No zoomz
//Creating a dialogue box creates zoomz so turn it off before camera updates
with (obj_camera)	{
	state=CAMERA_MODE.CAM_FOLLOW;
	following=player;
	}