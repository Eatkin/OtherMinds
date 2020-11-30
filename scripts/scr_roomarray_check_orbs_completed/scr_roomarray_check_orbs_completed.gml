//Created 30/08/19
//Last updated 30/08/19

//This checks if there's any orbs left in the level, and if there aren't, sets the orbs all completed flag
//There is one small snag - orbs become invisible before deleting so they can play a sound
//If there is one orb left, and its invisible, it sets the flag

var orbnum=instance_number(parent_orb);
var grid=global.roomarray;
var grid_height=ds_grid_height(grid);
if orbnum<=1
	{
		//Find our room in the grid
		var i;
		for (i=0;i<grid_height;i+=1)
			{
				if ds_grid_get(grid,ROOMARRAY.ROOM,i)=room
					{
						ds_grid_set(grid,ROOMARRAY.ORBSFOUND,i,true);
						scr_queue_notification(scr_return_text(585),NOTIFICATION.HINT);
						//Let's also quickly chcek secrets are complete
						if ds_grid_get(grid,ROOMARRAY.SECRETSNUMBER,i)=0
							{
								ds_grid_set(grid,ROOMARRAY.SECRETSFOUND,i,true);
							}
						else
							{
								ds_grid_set(grid,ROOMARRAY.SECRETSFOUND,i,false);
							}
						exit;
					}
			}
		
	}
else
	{
		//Find our room in the grid
		var i;
		for (i=0;i<grid_height;i+=1)
			{
				if ds_grid_get(grid,ROOMARRAY.ROOM,i)=room
					{
						//This just makes sure that we haven't accidentally said all orbs found if they're not
						ds_grid_set(grid,ROOMARRAY.ORBSFOUND,i,false);
						//Let's also quickly chcek secrets are complete
						if ds_grid_get(grid,ROOMARRAY.SECRETSNUMBER,i)=0
							{
								ds_grid_set(grid,ROOMARRAY.SECRETSFOUND,i,true);
							}
						else
							{
								ds_grid_set(grid,ROOMARRAY.SECRETSFOUND,i,false);
							}
						exit;
					}
			}
	}