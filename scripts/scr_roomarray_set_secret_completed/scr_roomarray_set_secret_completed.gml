//Created 30/08/19
//Last updated 30/08/19

//Just sets a secret as completed

var grid=global.roomarray;
var grid_height=ds_grid_height(grid);

//We have no easy way of checking if all secrets are complete, so we just decrease it by one every time we find a secret and flag as true when we hit 0
var i;
for (i=0;i<grid_height;i+=1)
	{
		if (ds_grid_get(grid,ROOMARRAY.ROOM,i)==room)
			{
				var secretsFound=ds_grid_get(grid,ROOMARRAY.SECRETSFOUND,i);
				if (secretsFound==true)
					{
						exit;
					}
				var secrets=ds_grid_get(grid,ROOMARRAY.SECRETSNUMBER,i);
				ds_grid_set(grid,ROOMARRAY.SECRETSNUMBER,i,secrets-1);
				if (secrets<=1)
					{
						scr_queue_notification(scr_return_text(586),NOTIFICATION.HINT);
						ds_grid_set(grid,ROOMARRAY.SECRETSFOUND,i,true);
					}
				
				//Increment the secrets discovered by one
				var discovered=grid[# ROOMARRAY.SECRETSDISCOVERED, i];
				ds_grid_set(grid, ROOMARRAY.SECRETSDISCOVERED,i,discovered+1)
				exit;
			}
	}