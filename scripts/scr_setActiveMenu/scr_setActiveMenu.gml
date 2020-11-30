var target=targetMenu;

obj_mainMenuManager.activeMenu=target;

//Set the mode of the new/load game buttons
if (target==Menu.LoadGame)
	with (obj_newLoadGameButton)
		mode="Load Game";
		
if (target==Menu.NewGame)
	with (obj_newLoadGameButton)
		mode="New Game";