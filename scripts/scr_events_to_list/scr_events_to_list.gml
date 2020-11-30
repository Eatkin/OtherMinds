//Created 09/09/19
//Last updated 09/09/19

//I want to save all the events to a list then convert to a string

var list=ds_list_create();
ds_list_add(list,global.edspaceevents_one);
ds_list_add(list,global.hint_events);
ds_list_add(list,global.edhouse_events);
ds_list_add(list,global.globalevents);
ds_list_add(list,global.overworld_events);
ds_list_add(list,global.ochre_events);
ds_list_add(list,global.timetrials);
ds_list_add(list,global.officeevents);
ds_list_add(list,global.tutorialTownEvents);
ds_list_add(list,global.mysteriousRoomEvents);
ds_list_add(list,global.edSpaceTwoEvents);
var _string=ds_list_write(list);
ds_list_destroy(list);

return _string;