var set=argument0;

//Loop through the room sets grid until we find the one we want
var name="Fuck fuck fuck fuc#k fuckf uckckfu kcfu you broke the game";

var grid=global.roomsets;
var height=ds_grid_height(grid);

for (var i=0; i<height; i+=1)
	if (grid[# ROOMGROUPCONSTS.REF, i]==set)	{
		name=grid[# ROOMGROUPCONSTS.NAME, i];
		break;
	}
	
return name;