/// @description Cutscene after EdSpace 2

showingcutscene=false;

//We have to have not flagged completed edspace 2 but also we must have beaten the edspace 2 boss
if (!scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.EDSPACE_TWO_COMPLETE) and scr_event_check_complete(global.edSpaceTwoEvents,EdSpaceTwoEvents.DEFEATEDDRD))
	{
		showingcutscene=true;
		global.edhouse_events=scr_event_set_complete(global.edhouse_events,EVENTS_EDHOUSE.EDSPACE_TWO_COMPLETE);
		global.softpause=true
		var sage=instance_create_layer(256,144,"players",obj_sage);
		//This is to set upthe camera correctly but think it gets overwritten at room start
		obj_speechbubble.x=sage.x;
		obj_speechbubble.y=sage.y;
		with (sage)
			{
				var text;
				text[0]=scr_return_text(662);
				text[1]=scr_return_text(663);
				text[2]=scr_return_text(664);
				text[3]=scr_return_text(665);
				text[4]=scr_return_text(666);
				for (var i=0; i<array_length_1d(text);i+=1)
					scr_queue_dialogue_box(text[i]);
			}
		timer=0;
	}
else
	instance_destroy();