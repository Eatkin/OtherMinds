//Created 30/08/19
//Last updated 30/08/19

//Adds rooms to the room array
//Argument0 - room reference
//Argument1 - room group
//Argument2 - All orbs found
//Argument3 - All secrets found
//Argument4 - Number of secrets

var grid=global.roomarray;
var height=ds_grid_height(grid);
var width=ds_grid_width(grid);
ds_grid_resize(grid,width,height+1);
ds_grid_set(grid,ROOMARRAY.ROOM,height,argument0);
ds_grid_set(grid,ROOMARRAY.ROOMSET,height,argument1);
ds_grid_set(grid,ROOMARRAY.ORBSFOUND,height,argument2);
ds_grid_set(grid,ROOMARRAY.SECRETSFOUND,height,argument3);
ds_grid_set(grid,ROOMARRAY.SECRETSNUMBER,height,argument4);
ds_grid_set(grid,ROOMARRAY.DISCOVERED,height,false);
ds_grid_set(grid,ROOMARRAY.ROOMNAME,height,room_get_name(argument0));
ds_grid_set(grid,ROOMARRAY.ORBSNUMBER,height,0);
ds_grid_set(grid,ROOMARRAY.SECRETSDISCOVERED,height,0);