//Created 01/09/19
//Last updated 01/09/19

//Add an item to the to do list
var ref=argument[0]
var name=argument[1];
var description=argument[2];
var grid=global.todo;
if argument_count>3
	{
		grid=argument[3];
	}
var height=ds_grid_height(grid);
var width=ds_grid_width(grid);
ds_grid_resize(grid,width,height+1);

//Now add the stuff
ds_grid_set(grid,TODO.REF,height,ref);
ds_grid_set(grid,TODO.NAME,height,name);
ds_grid_set(grid,TODO.DESCRIPTION,height,description);
ds_grid_set(grid,TODO.STATUS,height,TODOSTATUS.UNDISCOVERED);