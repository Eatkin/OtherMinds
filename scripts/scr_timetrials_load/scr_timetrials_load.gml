//Created 15/03/20
//Last updated 15/03/20

//we just want to load the times and room names into a ds grid and save to disk

var grid=global.besttimes;
var gridheight=ds_grid_height(grid);
var newgrid=ds_grid_create(0,0);

//read file and save it to the new grid
var file=file_text_open_read("times");
var gridstring=file_text_read_string(file);
file_text_close(file);

ds_grid_read(newgrid,gridstring);

var newgridheight=ds_grid_height(newgrid);

//Do the checksum
var sum=0;
for (var i=0; i<newgridheight-1; i+=1)
	{
		sum+=ds_grid_get(newgrid,1,i);
	}

if (ds_grid_get(newgrid,0,newgridheight-1)!=sum or ds_grid_get(newgrid,1,newgridheight-1)!=sum*3)
	{
		show_debug_message("Best times load failed");
		scr_timetrials_save();
		ds_grid_destroy(newgrid);
		exit;
	}

//If we're here, the checksum passed
for (var i=0; i<newgridheight-1; i+=1)
	{
		var roomname=ds_grid_get(newgrid,0,i);
		for (var j=0; j<gridheight; j+=1)
			{
				if (ds_grid_get(grid,BESTTIMES.ROOMNAME,j)==roomname)
					{
						var besttime=ds_grid_get(newgrid,1,i);
						ds_grid_set(grid,BESTTIMES.BESTTIME,j,besttime);
					}
			}
	}
	
ds_grid_destroy(newgrid);

