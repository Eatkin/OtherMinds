/// @description

var trialcounter=0;
var trialnumber=ds_grid_height(global.besttimes); //How many timetrials are there
//Enum magic - each trial is stored in a power of 2 so we do 2^i
for (var i=0; i<trialnumber; i+=1)
	if (scr_event_check_complete(global.timetrials,power(2,i)))
		trialcounter+=1;
	
with (obj_timetrialblock)
	timetrialnumber-=trialcounter;