//Created 09/09/19
//Last updated 09/09/19

//events to grid in reverse
//Reads the string, converts to a grid then updates all the event holders

var _list=ds_list_create();
ds_list_read(_list,argument0);

//Now loop through the list to find all the thingies
//We must read in reverse order - no we don't why the hell did I think that
//I'm afraid this is just really tedious

//I do a loop so I don't try save non existent values
var _listsize=ds_list_size(_list);
for (var i=0; i<_listsize; i+=1)
	{
		switch (i)
			{
				case 0:
					{
						global.edspaceevents_one=ds_list_find_value(_list,0);
						break;
					}
				case 1:
					{
						global.hint_events=ds_list_find_value(_list,1);
						break;
					}
				case 2:
					{
						global.edhouse_events=ds_list_find_value(_list,2);
						break;
					}
				case 3:
					{
						global.globalevents=ds_list_find_value(_list,3);
						break;
					}
				case 4:
					{
						global.overworld_events=ds_list_find_value(_list,4);
						break;
					}
				case 5:
					{
						global.ochre_events=ds_list_find_value(_list,5);
						break;
					}
				case 6:
					{
						global.timetrials=ds_list_find_value(_list,6);
						break;
					}
				case 7:
					{
						global.officeevents=ds_list_find_value(_list,7);
						break;
					}
				case 8:
					global.tutorialTownEvents=ds_list_find_value(_list,8);
					break;
				case 9:
					global.mysteriousRoomEvents=ds_list_find_value(_list,9);
					break;
				case 10:
					global.edSpaceTwoEvents=ds_list_find_value(_list,10);
					break;
			}
	}

ds_list_destroy(_list);