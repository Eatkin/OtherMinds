//created 02/08/19
//last updated 09/08/19

//Sets the given event as completed
var eventset=argument0;
var event=argument1;

//Yep this is just magic
eventset=eventset|event;

return eventset;