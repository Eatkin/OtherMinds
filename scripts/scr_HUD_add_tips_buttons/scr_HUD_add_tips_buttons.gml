//Created: 04/07/19
//Last updated: 04/07/19

//This adds buttons to the end of the grid

var i, gridindex,j,k;

for (k=0; k<ds_grid_width(global.tipsgrid);k+=1)
	{
		if global.tipsgrid[# k, HUDTips.BUTTON]=-1
			{
				gridindex=k;
				break;
			}
	}
	
j=0;
for (i=gridindex;i<gridindex+argument_count;i+=1)
	{
		ds_grid_set(global.tipsgrid,i,HUDTips.BUTTON,argument[j]);
		j+=1;
	}