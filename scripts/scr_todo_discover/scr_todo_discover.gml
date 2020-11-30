//Created 01/09/19
//Last updated 01/09/19

var ref=argument[0];

var grid=global.todo;
if argument_count>1
	{
		grid=argument[1];
	}
var height=ds_grid_height(grid);

//Find the name in the grid then set it to incomplete if its undiscovered
var i;
for (i=0;i<height;i+=1)
	{
		if ds_grid_get(grid,TODO.REF,i)=ref
			{
				if (ds_grid_get(grid,TODO.STATUS,i)==TODOSTATUS.UNDISCOVERED)
					{
						ds_grid_set(grid,TODO.STATUS,i,TODOSTATUS.INCOMPLETE);
						//This makes sure not to spam loads of to dos
						if (global.currentinstance==id)
							{
								var name=ds_grid_get(grid,TODO.NAME,i);
								scr_queue_notification(name,NOTIFICATION.TODONEW);
							}
						//Sort INSIDE of the loop because otherwise there's cases where it repeatedly sorts
						//Apparently it gets sorted differently each time as well lol
						ds_grid_sort(grid,TODO.STATUS,true);
					}
			}
	}