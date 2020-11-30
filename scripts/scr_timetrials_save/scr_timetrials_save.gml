//Created 15/03/20
//Last updated 15/03/20

//we just want to load the times and room names into a ds grid and save to disk

var grid=global.besttimes;
var gridheight=ds_grid_height(grid);
var newgrid=ds_grid_create(2,gridheight+1);

var sum=0;
for (var i=0; i<gridheight; i+=1)
	{
		var roomname=ds_grid_get(grid,BESTTIMES.ROOMNAME,i);
		var besttime=ds_grid_get(grid,BESTTIMES.BESTTIME,i);
		sum+=besttime;
		ds_grid_set(newgrid,0,i,roomname);
		ds_grid_set(newgrid,1,i,besttime);
	}

//Some garbage numbers to minimise tampering although it's not hard to break
ds_grid_set(newgrid,0,i,sum);
ds_grid_set(newgrid,1,i,sum*3);
	
var gridstring=ds_grid_write(newgrid);
ds_grid_destroy(newgrid);

var file=file_text_open_write("times");
file_text_write_string(file,gridstring);
file_text_close(file);