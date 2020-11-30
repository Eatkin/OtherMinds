//Created 28/08/19
//Last updated 28/08/19

//Removes an item from inventory (if possible)

var grid=global.inventory;
var obj=object_index;
if argument_count>0
	{
		obj=argument[0];
	}
if argument_count>1
	{
		grid=argument[1];
	}

//Loops through the grid to find the relevant object index
var i;
for (i=0;i<ds_grid_height(grid);i+=1)
	{
		if ds_grid_get(grid,INVENTORY.ITEMID,i)=obj
			{
				var quant=ds_grid_get(grid,INVENTORY.QUANTITY,i);
				if quant>0
					{
						ds_grid_set(grid,INVENTORY.QUANTITY,i,quant-1);
					}
				return 0;
			}
	}