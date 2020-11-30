//created 30/08/19
//Last updated 30/08/19

//Set the port and its linked instance as used
//Also I'm reusing enums because I'll never actually need to look at this

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
	if (myX==xx and myY=yy)
		break;
}

//If we are already active, exit
if (grid[# InstanceGrid.CollectedStatus, j]==INSTANCEMAP.ACTIVE)
	exit;

//Else we set it as active
grid[# InstanceGrid.CollectedStatus, j]=INSTANCEMAP.ACTIVE;

//Now repeat the process with the destination (sorry)
myX=destination.xstart;
myY=destination.ystart;

//We don't need to find the room name again because i doesn't change
for (var j=i; j<gridHeight; j+=1)	{
	var xx=grid[# InstanceGrid.X, j];
	var yy=grid[# InstanceGrid.Y, j];
	if (myX==xx and myY=yy)
		break;
}

//Else we set it as active and reduce secrets by 1 this time
grid[# InstanceGrid.CollectedStatus, j]=INSTANCEMAP.ACTIVE;
scr_roomarray_set_secret_completed();