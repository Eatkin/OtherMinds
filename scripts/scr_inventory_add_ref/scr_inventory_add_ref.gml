//Created 28/08/19
//Last updated 28/08/19

//Argument0 - object reference
//Argument1 - item name
//Argument2 - quantity
//Argument3 - sprite
//Argument4 - Description

var grid=global.inventory;
if argument_count>5
	{
		grid=argument[5];
	}
var height=ds_grid_height(grid);
var width=ds_grid_width(grid);
ds_grid_resize(grid,width,height+1);
ds_grid_set(grid,INVENTORY.ITEMID,height,argument[0]);
ds_grid_set(grid,INVENTORY.ITEMNAME,height,argument[1]);
ds_grid_set(grid,INVENTORY.QUANTITY,height,argument[2]);
ds_grid_set(grid,INVENTORY.SPRITE,height,argument[3]);
ds_grid_set(grid,INVENTORY.DESCRIPTION,height,argument[4]);
ds_grid_set(grid,INVENTORY.OBJNAME,height,object_get_name(argument[0]));