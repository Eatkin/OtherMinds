//Created: 17/06/19
//Last updated: 17/06/19

//Sets all values to null

for (i=0;i<ds_grid_width(global.tipsgrid);i+=1)
	{
		ds_grid_set(global.tipsgrid,i,HUDTips.BUTTON,-1);
		ds_grid_set(global.tipsgrid,i,HUDTips.TEXT,-1);
	}