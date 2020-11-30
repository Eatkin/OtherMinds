//Created 20/09/19
//Last updated 20/09/19

/*Arg0 - the room index
arg1 - x pos
arg2 - y pos
arg3 - xscale
arg4 - yscale
*/

//Then find orbs and secrets on our own

var map=themap; //The ds grid
var height=ds_grid_height(map);
if scr_room_check_discovered(argument0)=false
	{
		exit;
	}

ds_grid_resize(map,ds_grid_width(map),ds_grid_height(map)+1);
ds_grid_add(themap,MAPDATA.ROOMNUMBER,height,argument0);
ds_grid_add(themap,MAPDATA.X,height,argument1);
ds_grid_add(themap,MAPDATA.Y,height,argument2);
ds_grid_add(themap,MAPDATA.XSCALE,height,argument3);
ds_grid_add(themap,MAPDATA.YSCALE,height,argument4);

//Find the orbs and secrets status from the roomarray
var grid=global.roomarray
var i, orbs, secrets;
for (i=0; i<ds_grid_height(grid); i+=1)
	{
		if ds_grid_get(grid,ROOMARRAY.ROOM,i)=argument0
			{
				orbs=ds_grid_get(grid,ROOMARRAY.ORBSFOUND,i);
				secrets=ds_grid_get(grid,ROOMARRAY.SECRETSFOUND,i);
				break;
			}
	}
	
ds_grid_add(themap,MAPDATA.ORBS,height,orbs);
ds_grid_add(themap,MAPDATA.SECRETS,height,secrets);