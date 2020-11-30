/// @description Step code for movement etc
// You can write your code in this editor

event_inherited();

scr_states_step();

if (dialogueprevious==4)
	{
		global.globalevents=scr_event_set_complete(global.globalevents,EVENTS_GLOBAL.TALKTOSENTIENTROCK);
	}
	
var finishedtalking=ds_queue_empty(global.dialoguequeue);
if (dialogueprevious!=-1 and finishedtalking==true)
	{
		var player=global.currentinstance;
		with (player)
			{
				scr_todo_discover(13);
			}
	}

//This should only occur if we HAVEN'T completed the keep sentient rock company task
if (dialoguecomplete and finishedtalking and !scr_todo_checkComplete(13))
	{
		var player=global.currentinstance;
		with (player)
			{
				scr_todo_complete(13);
				scr_todo_discover(20);
			}
		event_perform(ev_create,0);		//Force him to re-initialise his text by performing the create event
										//This is the worst code I've ever written
	}
	
//Now we do the hints management, we have a list containing 3 hints 
//Basically we move thru those hints instead of the default order
if (hintsdialogue==false and finishedtalking==false)
	{
		hintsdialogue=true;
		//Find what dialogue has just been played
		var index=ds_list_find_index(hintslist,dialogueprevious);
		var size=ds_list_size(hintslist);
		size-=1;
		if (index!=size)
			{
				dialogueprevious=ds_list_find_value(hintslist,index+1)-1;
			}
	}
	
if (finishedtalking==true)
	{
		//If he's told us all the hints there are to know we complete the event
		if (dialogueprevious==array_length_1d(text)-1 and dialoguecomplete)
			scr_todo_complete(20);
		hintsdialogue=false;
	}