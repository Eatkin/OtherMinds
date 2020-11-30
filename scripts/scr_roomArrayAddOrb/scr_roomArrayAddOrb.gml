//Adds +1 to the orb count in the room array

//Find the room
var grid=global.roomarray;
var height=ds_grid_height(grid);

for (var i=0; i<height; i+=1)
	if (room==grid[# ROOMARRAY.ROOM, i])	{
		grid[# ROOMARRAY.ORBSNUMBER, i]+=1;
	}