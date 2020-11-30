/// @description set up cutscene

showingcutscene=false;

if (scr_event_check_complete(global.globalevents,EVENTS_GLOBAL.PASSTWO)==false)
	{
		showingcutscene=true;
		global.globalevents=scr_event_set_complete(global.globalevents,EVENTS_GLOBAL.PASSTWO);
		global.softpause=true
		var player=parent_main_character;
		player.directionfacing=1;		//Face right, because looks stupid otherwise
		var sage=instance_create_layer(player.x,player.y,"players",obj_sage); //Ed's co-ords
		//This is to set upthe camera correctly but think it gets overwritten at room start
		obj_speechbubble.x=sage.x;
		obj_speechbubble.y=sage.y;
		with (sage)
			{
				var text;
				text[0]=scr_return_text(603);
				text[1]=scr_return_text(604);
				text[2]=scr_return_text(605);
				for (var i=0; i<array_length_1d(text);i+=1)
					{
						scr_queue_dialogue_box(text[i]);
					}
			}
		timer=0;
	}
else
	{
		instance_destroy();
	}