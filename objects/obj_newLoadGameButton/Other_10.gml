/// @description

//Load game if it exists, otherwise we play a little animation to say no
if (mode=="Load Game")	{
	if (gameExists)
		scr_loadGameFromMenu(gameNum);
	else	{
		shake=true;
		audio_play_sound(snd_menu_no,0,false);
	}
}

if (mode=="New Game")	{
	if (!gameExists)
		scr_newGameFromMenu(gameNum);
	else	{
		//Create a confirmation box  and set parameters
		var confirmBox=instance_create_layer(0,0,layer,obj_confirmOverwrite);
		confirmBox.linkedGame=gameNum;
	}
}