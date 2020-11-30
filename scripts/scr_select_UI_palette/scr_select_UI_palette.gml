//Created 13/02/20
//Last upadated 13/02/20

//We find our room in the roomarray
var grid=global.roomarray;
var height=ds_grid_height(grid);
var roomgroup=-1;
var palette=0;
for (var i=0; i<height; i+=1)
	{
		if (room==ds_grid_get(grid,ROOMARRAY.ROOM,i))
			{
				roomgroup=ds_grid_get(grid,ROOMARRAY.ROOMSET,i);
				break;
			}
	}
	
switch (roomgroup)
	{
		case ROOMGROUP.EDSPACE_ONE:
			palette=0;
			break;
		case ROOMGROUP.ED_HOUSE:
			palette=1;
			break;
		case ROOMGROUP.OVERWORLD:
			palette=2;
			break;
		case ROOMGROUP.OCHREHILL:
			palette=3;
			break;
		case ROOMGROUP.OFFICES:
			palette=4;
			break;
		case ROOMGROUP.EDSPACE_ONE_CHALLENGE:
			palette=5;
			break;
		default:
			palette=4;		//Brown for main menu etc
			break;
	}
	
return palette;