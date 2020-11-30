//Created 01/09/19
//Last updated 01/09/19

var ref=argument[0];

var grid=global.todo;
if argument_count>1
	{
		grid=argument[1];
	}
var height=ds_grid_height(grid);

//Find the name in the grid then set it to complete regardless of previous status
var i;
for (i=0;i<height;i+=1)
	{
		//If we find the ref, we then check if the to do is complete and if it is, return true
		if (ds_grid_get(grid,TODO.REF,i)==ref and ds_grid_get(grid,TODO.STATUS,i)==TODOSTATUS.COMPLETE)
			return true;
	}

return false;