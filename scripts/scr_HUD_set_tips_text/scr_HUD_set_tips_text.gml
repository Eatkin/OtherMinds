//Created: 17/06/19
//Last updated: 17/06/19

//This goes through the grid and sets the values to the key reference

var i;
for (i=0;i<argument_count;i+=1)
	{
		ds_grid_set(global.tipsgrid,i,HUDTips.TEXT,argument[i]);
	}
for (i=argument_count;i<ds_grid_width(global.tipsgrid);i+=1)
	{
		ds_grid_set(global.tipsgrid,i,HUDTips.TEXT,-1);
	}