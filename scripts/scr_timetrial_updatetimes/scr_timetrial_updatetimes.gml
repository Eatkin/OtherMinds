//Created 15/03/20
//Last updated 15/03/20

//Compares time to the current best time and updates if necessary

var time=argument0;

var grid=global.besttimes;
var gridheight=ds_grid_height(grid);
var roomname=room_get_name(room);
//Find the room in the grid
for (var i=0; i<gridheight; i+=1)
	{
		if (ds_grid_get(grid,BESTTIMES.ROOMNAME,i)==roomname)
			{
				var besttime=ds_grid_get(grid,BESTTIMES.BESTTIME,i);
				break;
			}
	}
	
if (time<besttime)
	{
		ds_grid_set(grid,BESTTIMES.BESTTIME,i,time);
		scr_timetrials_save();
		return 1;
	}

return 0;