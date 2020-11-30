/*
TO RECORD A NEW DEMO:
Set global.attract=true at game start								(scr_setup_gameplay_variables)
Set the room start code to create obj_attract_record at room start	(scr_global_roomstart)
(That just involves commenting out a couple lines)
Data is written to local folder in .txt, then copy to project
Set the random seed in obj_debugging (event key press 4) and save it here to be recalled!*/

var numberofdemos=9;

//These are saved as a really, really long string lol
//Anyway time to stop being an asbolute retard and store these in included files instead of in plain code

global.demos=ds_grid_create(4,numberofdemos);
//RNG seed, room name and recording data (as a file)
ds_grid_set(global.demos,0,0,12345); 
ds_grid_set(global.demos,1,0,room_EdSpace1_5); //index 20
ds_grid_set(global.demos,3,0,2); //global.rng values

ds_grid_set(global.demos,0,1,54312);
ds_grid_set(global.demos,1,1,rm_EdSpace1_4_5); //index 18
ds_grid_set(global.demos,3,1,3); //global.rng values

ds_grid_set(global.demos,0,2,174839);
ds_grid_set(global.demos,1,2,rm_Edcellar); //index 30
ds_grid_set(global.demos,3,2,3); //global.rng values

ds_grid_set(global.demos,0,3,777777777);
ds_grid_set(global.demos,1,3,rm_overworld_puzzlecave); //rm 33
ds_grid_set(global.demos,3,3,0); //global.rng values

ds_grid_set(global.demos,0,4,2864885759);
ds_grid_set(global.demos,1,4,rm_ochrehill_4); //Index 42
ds_grid_set(global.demos,3,4,1); //global.rng values

ds_grid_set(global.demos,0,5,438506992);
ds_grid_set(global.demos,1,5,rm_ochrehill_7); //index 46
ds_grid_set(global.demos,3,5,1);

ds_grid_set(global.demos,0,6,10101);
ds_grid_set(global.demos,1,6,rm_office_vent_room_two); //index 54
ds_grid_set(global.demos,3,6,3);

ds_grid_set(global.demos,0,7,11223344);
ds_grid_set(global.demos,1,7,rm_office_gauntlet); //index 59
ds_grid_set(global.demos,3,7,0);

ds_grid_set(global.demos,0,8,11223344);
ds_grid_set(global.demos,1,8,rm_EdSpace2_1); //index 65
ds_grid_set(global.demos,3,8,1);

//Here'a for loop to load all the files in from included files
var dir=working_directory;

for (var i=0; i<numberofdemos; i+=1)	{
	var fname=dir+"Attract"+string(i)+".txt";
	var file=file_text_open_read(fname);
	var atrStr=file_text_read_string(file);
	file_text_close(file);
	//Then write it to the grid
	ds_grid_set(global.demos,2,i,atrStr);
}

//Now generate a list of demos so they don't play multiple times in a row
global.attractlist=ds_list_create();
for (var i=0; i<numberofdemos; i+=1)
	ds_list_add(global.attractlist,i);
ds_list_shuffle(global.attractlist);
global.attractindex=0;