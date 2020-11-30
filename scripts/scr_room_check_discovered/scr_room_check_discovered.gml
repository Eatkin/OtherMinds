//Created 22/09/19
//Last updated 22/09/19

var grid=global.roomarray;
var height=ds_grid_height(grid);

//Find our room in the grid
var i;
for (i=0;i<height;i+=1)
	{
		if ds_grid_get(grid,ROOMARRAY.ROOM,i)=argument0
			{
				return ds_grid_get(grid,ROOMARRAY.DISCOVERED,i);
			}
	}