//This just finds how many entries there are for attract mode
//It will randomly load a room and go there and also set global.attract=true

randomise();

var gridheight=ds_grid_height(global.demos);
var attractnumber=ds_list_find_value(global.attractlist,global.attractindex);
global.attractindex+=1;
if (global.attractindex>=ds_list_size(global.attractlist))
	{
		ds_list_shuffle(global.attractlist);
		global.attractindex=0;
	}

var roomtogo=ds_grid_get(global.demos,1,attractnumber);
global.rng=ds_grid_get(global.demos,3,attractnumber);
var seed=ds_grid_get(global.demos,0,attractnumber);
randomise();
random_set_seed(seed);

global.attract=true;

//Set seed
room_goto(roomtogo);