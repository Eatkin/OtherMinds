//Created 01/09/19
//Last updated 01/09/19

var ref=argument[0];

var grid=global.todo;
if argument_count>1
	{
		grid=argument[1];
	}
var height=ds_grid_height(grid);

//Find the name in the grid then set it to complete regardless of previous status
var i;
for (i=0;i<height;i+=1)
	{
		if (ds_grid_get(grid,TODO.REF,i)==ref)
			{
				if (ds_grid_get(grid,TODO.STATUS,i)!=TODOSTATUS.COMPLETE)
					{
						if global.currentinstance=id
							{
								var name=ds_grid_get(grid,TODO.NAME,i);
								scr_queue_notification(name,NOTIFICATION.TODOCOMPLETE);
							}
						ds_grid_set(grid,TODO.STATUS,i,TODOSTATUS.COMPLETE);
						ds_grid_sort(grid,TODO.STATUS,true);
					}
			}
	}

//Let's do a check for calander events 1
var calanderEventsOneComplete=true;
calanderEventsOneComplete*=scr_todo_checkComplete(6);
calanderEventsOneComplete*=scr_todo_checkComplete(7);
calanderEventsOneComplete*=scr_todo_checkComplete(8);
calanderEventsOneComplete*=scr_todo_checkComplete(9);
calanderEventsOneComplete*=scr_todo_checkComplete(14);
calanderEventsOneComplete*=scr_todo_checkComplete(25);		//This one requires the note returning to New Deal
//calanderEventsOneComplete*=scr_todo_checkComplete(17);	//NO DO NOT INCLUDE THIS ONE! What were you thinking? This is the HEAD HOME event which DOESN'T TRIGGER UNTIL THE CUTSCENE SO THIS WILL NEVER HAPPEN!
															//WHAT WERE YOU THINKING!!

if (calanderEventsOneComplete==true and !instance_exists(obj_calanderEventsOneCompleteCutsceneCreator))
	instance_create_layer(x,y,layer,obj_calanderEventsOneCompleteCutsceneCreator);