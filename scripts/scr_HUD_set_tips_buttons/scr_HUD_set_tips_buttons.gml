//Created: 17/06/19
//Last updated: 17/06/19

//I want to go through the grid and set values to the first rows to the number of arguments

var i;
for (i=0;i<argument_count;i+=1)
	{
		ds_grid_set(global.tipsgrid,i,HUDTips.BUTTON,argument[i]);
	}
for (i=argument_count;i<ds_grid_width(global.tipsgrid);i+=1)
	{
		ds_grid_set(global.tipsgrid,i,HUDTips.BUTTON,-1);
	}