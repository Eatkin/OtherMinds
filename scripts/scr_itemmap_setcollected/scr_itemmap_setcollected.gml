//Created 28/08/19
//Last updated 28/08/19

//Set the orb as collected

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

for (var j=i; j<gridHeight; j+=1)	{
	var xx=grid[# InstanceGrid.X, j];
	var yy=grid[# InstanceGrid.Y, j];
	if (myX==xx and myY=yy)	{
		break;
	}
}

grid[# InstanceGrid.CollectedStatus, j]=INSTANCEMAP.ACTIVE;