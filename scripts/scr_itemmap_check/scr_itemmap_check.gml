//Created 28/08/19
//Last updated 28/08/19

//Search the orbmap for our id
//If its not there, add it
//If it's there and we've been collected, destroy

var myX=xstart;
var myY=ystart;
var roomName=room_get_name(room);

var grid=global.instancegrid;
var gridHeight=ds_grid_height(grid);

//Find the room name
for (var i=0; i<gridHeight; i+=1)	{
	if (grid[# InstanceGrid.RoomName, i]==roomName)
		break;
}
var found=false;

for (var j=i; j<gridHeight; j+=1)	{
	var xx=grid[# InstanceGrid.X, j];
	var yy=grid[# InstanceGrid.Y, j];
	if (myX==xx and myY=yy)	{
		found=true;
		break;
	}
}

if (found and grid[# InstanceGrid.CollectedStatus, j]==INSTANCEMAP.ACTIVE)
	instance_destroy();

if (!found)	{
	ds_grid_resize(grid,InstanceGrid.Max,gridHeight+1)
	grid[# InstanceGrid.RoomName, gridHeight]=roomName;
	grid[# InstanceGrid.X, gridHeight]=myX;
	grid[# InstanceGrid.Y, gridHeight]=myY;
	grid[# InstanceGrid.CollectedStatus, gridHeight]=INSTANCEMAP.INACTIVE;
}

//Sort the grid by room name
ds_grid_sort(grid,InstanceGrid.RoomName,true);