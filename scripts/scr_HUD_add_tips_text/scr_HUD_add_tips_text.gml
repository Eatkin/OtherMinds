//Created: 04/07/19
//Last updated: 04/07/19

//This goes through the grid and adds the values to the key reference to the end

var i, gridindex, j, k;
for (k=0; k<ds_grid_width(global.tipsgrid);k+=1)
	{
		if global.tipsgrid[# k, HUDTips.TEXT]=-1
			{
				gridindex=k;
				break;
			}
	}
j=0;
for (i=gridindex;i<gridindex+argument_count;i+=1)
	{
		ds_grid_set(global.tipsgrid,i,HUDTips.TEXT,argument[j]);
		j+=1;
	}