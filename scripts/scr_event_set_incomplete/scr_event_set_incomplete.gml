//created 02/08/19
//last updated 09/08/19

//Sets the given event as incomplete
//Why would I ever need to do this? I don't know but I'm excited about binary operators
var eventset=argument0;
var event=argument1;

//If the event isn't actually completed already then this script is stupid and pointless so do the check
if (scr_event_check_complete(eventset,event)==true)
	{
		eventset=eventset&!event;
	}
	
return 1;