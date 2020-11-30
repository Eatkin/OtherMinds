//Created 03/09/19
//Last updated 03/09/19

//Adds rooms to the room array
//Argument0 - room set ref (enum)
//Argument1 - name

var grid=global.roomsets;
var height=ds_grid_height(grid);
var width=ds_grid_width(grid);
ds_grid_resize(grid,width,height+1);
ds_grid_set(grid,ROOMGROUPCONSTS.REF,height,argument0);
ds_grid_set(grid,ROOMGROUPCONSTS.NAME,height,argument1);