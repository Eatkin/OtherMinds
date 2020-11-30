//Created 22/09/19
//Last updated 22/09/19

//Just a list of coordinates to draw lines between. Includes room set.

//Add 0.5 to coords so the connections are drawn from the centre of the cells
var x1=argument0;
var y1=argument1;
var x2=argument2;
var y2=argument3;
var room_1=argument4;
var room_2=argument5;

if scr_room_check_discovered(room_1)=false or scr_room_check_discovered(room_2)=false
	{
		exit;
	}

var grid=connections; //The ds grid
var height=ds_grid_height(grid);

ds_grid_resize(connections,ds_grid_width(grid),ds_grid_height(grid)+1);
ds_grid_add(connections,CONNECTION.X_1,height,x1);
ds_grid_add(connections,CONNECTION.Y_1,height,y1);
ds_grid_add(connections,CONNECTION.X_2,height,x2);
ds_grid_add(connections,CONNECTION.Y_2,height,y2);
ds_grid_add(connections,CONNECTION.ROOM_1,height,room_1);
ds_grid_add(connections,CONNECTION.ROOM_2,height,room_2);