/// @description set up cutscene

showingcutscene=false;

if (scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.EDSPACE_ONE_COMPLETE)==false)
	{
		showingcutscene=true;
		global.edhouse_events=scr_event_set_complete(global.edhouse_events,EVENTS_EDHOUSE.EDSPACE_ONE_COMPLETE);
		global.softpause=true
		var sage=instance_create_layer(256,144,"players",obj_sage);
		//This is to set upthe camera correctly but think it gets overwritten at room start
		obj_speechbubble.x=sage.x;
		obj_speechbubble.y=sage.y;
		var greenkey=scr_inventory_check(obj_key_green);
		var laserdisk=scr_inventory_check(obj_laser_diskvol1);
		var masterplan=scr_inventory_check(obj_masterplan);
		with (sage)
			{
				var text;
				text[0]=scr_return_text(251);
				text[1]=scr_return_text(252);
				text[2]=scr_return_text(253);
				text[3]=scr_return_text(254);
				var i=4;
				if greenkey=true
					{
						text[i]=scr_return_text(255);
						i+=1;
					}
				if laserdisk=true
					{
						text[i]=scr_return_text(256);
						i+=1;
					}
				if masterplan=true
					{
						text[i]=scr_return_text(257);
					}
				for (var i=0; i<array_length_1d(text);i+=1)
					{
						scr_queue_dialogue_box(text[i]);
					}
			}
		timer=0;
	}
else
	instance_destroy();