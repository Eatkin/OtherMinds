//created 10/09/19
//last updated 10/09/19

//This just marks the given todo as failed

var ref=argument[0];

var grid=global.todo;
if argument_count>1
	{
		grid=argument[1];
	}
var height=ds_grid_height(grid);

//Find the name in the grid then set it to failed regardless of previous status
var i;
for (i=0;i<height;i+=1)
	{
		if ds_grid_get(grid,TODO.REF,i)=ref
			{
				if ds_grid_get(grid,TODO.STATUS,i)!=TODOSTATUS.FAILED
					{
						if global.currentinstance=id
							{
								var name=ds_grid_get(grid,TODO.NAME,i);
								scr_queue_notification(name,NOTIFICATION.TODOFAIL);
							}
						ds_grid_set(grid,TODO.STATUS,i,TODOSTATUS.FAILED);
						ds_grid_sort(grid,TODO.STATUS,true);
					}
			}
	}