//Created 06/12/19
//Last updated 06/12/19

//This finds the calling instances id on the list and removes it!

//So find our room ref
var grid=global.mapenhancergrid;
var width=ds_grid_width(grid);
var height=ds_grid_height(grid);
var currentinst=id

for (var i=0; i<height; i+=1)
	{
		if ds_grid_get(grid,MAPENHANCER.ROOM,i)!=room
			{
				continue;
			}
		var inst=ds_grid_get(grid,MAPENHANCER.ITEMID,i);
		//If the instance does not exist, we must shift every row down one and set i-=1
		//What a very fun loop lol oh god this is never going to make sense ever again
		if currentinst=inst
			{
				for (var j=i; j<height-1; j+=1)
					{
						for (k=MAPENHANCER.ROOM; k<=MAPENHANCER.ITEMY; k+=1)
							{
								ds_grid_set(grid,k,j,ds_grid_get(grid,k,j+1));
							}
					}
				//Now update i and height to make sure nothing gets fucked up!!! Also resize the grid
				i-=1;
				height-=1;
				ds_grid_resize(grid,width,height);
			}
	}
	