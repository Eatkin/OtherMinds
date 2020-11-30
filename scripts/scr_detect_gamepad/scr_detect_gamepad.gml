//Created: 18/06/19
//Last updated: 18/06/19

//When I get to the stage for custom key bindings, I can just replace the fixed variables with
//uh..variable ones
//Also I am stupid
//I don't need to redefine the keys because its already done lolololol

switch(async_load[? "event_type"])
	{
		case "gamepad discovered":
			{
				global.pad = async_load[? "pad_index"];
				//gamepad_set_button_threshold(global.pad, 0.1);
				gamepad_set_axis_deadzone(global.pad, global.deadzone);
				//If this is the first time picking up a gamepad we do it automatically, in all future times we override it
				if global.hasdetectedgamepad=false
					{
						global.input=gamepad;
						global.hasdetectedgamepad=true;
						//Try to guess what gamepad we're using
						var type=string_lower(gamepad_get_description(global.pad));
						//global.gamepadtype=PAD.XBOX;
						/*Obseleting this because it doesn't work
						if string_count("xbox",type)>0
							{
								global.gamepadtype=PAD.XBOX;
							}
						else if (string_count("playstation",type)>0 or string_count("dual",type)>0)
							{
								global.gamepadtype=PAD.PS;
							}
						else if string_count("nintendo",type)>0
							{
								global.gamepadtype=PAD.NINTENDO;
							}*/
							
					}
				break;
			}
		case "gamepad lost":
			{
				global.hasdetectedgamepad=false;
				global.pad=-1;
				global.input=keyboard;
				break;
			}
	}