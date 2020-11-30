/// @description


//go thru global.demos and find the row we want
var grid=global.demos;
var gridheight=ds_grid_height(grid);
for (var i=0; i<gridheight; i+=1)
	if (ds_grid_get(grid,1,i)==room)	{
		//rngseed=ds_grid_get(grid,0,i);
		var gridstring=ds_grid_get(grid,2,i);
		break;
	}
/*	
randomise();
random_set_seed(seed);*/

//Some text stuff
demonum=i+1;
demototal=gridheight;


inputsgrid=ds_grid_create(0,0);
ds_grid_read(inputsgrid,gridstring);

frame=0;

var guiwidth=display_get_gui_width();
var guiheight=display_get_gui_height();
imagex=guiwidth*0.5;
imagey=guiheight*0.2;
active=false;