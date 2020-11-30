//Created 04/12/19
//Last updated 04/12/19

//So this executes at room start
//1 - we check if we have any grid references, if not we will go through and add all the items!
//2 - If we already have grid references, we go through and check every instance on the map still exists, remove them if not!
//^ 2 can be called using scr_mapenhancer_upate

var grid=global.mapenhancergrid;
var width=ds_grid_width(grid);
var height=ds_grid_height(grid);
for (var i=0; i<height; i+=1)
	{
		if ds_grid_get(grid,0,i)=room
			{
				scr_mapenhancer_update();
				exit;
			}
	}
	
//We will have exited the script by now if our room reference has been found
//So cycle thru and add all the items now!!!
if instance_number(parent_orb)>0
	{
		for (var i=0; i<instance_number(parent_orb);i+=1)
			{
				var inst=instance_find(parent_orb,i);
				//Write the instance to the grid!!!
				//Also resize the grid
				height+=1;
				ds_grid_resize(grid,width,height)
				ds_grid_set(grid,MAPENHANCER.ROOM,height-1,room);
				ds_grid_set(grid,MAPENHANCER.ITEMID,height-1,inst.id);
				ds_grid_set(grid,MAPENHANCER.ITEMTYPE,height-1,ME_TYPE.ORB);
				ds_grid_set(grid,MAPENHANCER.ITEMX,height-1,inst.x/room_width);
				ds_grid_set(grid,MAPENHANCER.ITEMY,height-1,inst.y/room_height);
			}
	}
if instance_number(obj_teleporter)>0
	{
		for (var i=0; i<instance_number(obj_teleporter);i+=1)
			{
				var inst=instance_find(obj_teleporter,i);
				//Write the instance to the grid!!!
				//Also resize the grid
				height+=1;
				ds_grid_resize(grid,width,height)
				ds_grid_set(grid,MAPENHANCER.ROOM,height-1,room);
				ds_grid_set(grid,MAPENHANCER.ITEMID,height-1,inst.id);
				ds_grid_set(grid,MAPENHANCER.ITEMTYPE,height-1,ME_TYPE.TELEPORTER);
				ds_grid_set(grid,MAPENHANCER.ITEMX,height-1,inst.x/room_width);
				ds_grid_set(grid,MAPENHANCER.ITEMY,height-1,inst.y/room_height);
			}
	}
if instance_number(obj_door)>0
	{
		for (var i=0; i<instance_number(obj_door);i+=1)
			{
				var inst=instance_find(obj_door,i);
				//Write the instance to the grid!!!
				//Also resize the grid
				height+=1;
				ds_grid_resize(grid,width,height)
				ds_grid_set(grid,MAPENHANCER.ROOM,height-1,room);
				ds_grid_set(grid,MAPENHANCER.ITEMID,height-1,inst.id);
				ds_grid_set(grid,MAPENHANCER.ITEMTYPE,height-1,ME_TYPE.DOOR);
				ds_grid_set(grid,MAPENHANCER.ITEMX,height-1,inst.x/room_width);
				ds_grid_set(grid,MAPENHANCER.ITEMY,height-1,inst.y/room_height);
			}
	}
if instance_number(parent_collectable)>0
	{
		for (var i=0; i<instance_number(parent_collectable);i+=1)
			{
				var inst=instance_find(parent_collectable,i);
				//Write the instance to the grid!!!
				//Also resize the grid
				height+=1;
				ds_grid_resize(grid,width,height)
				ds_grid_set(grid,MAPENHANCER.ROOM,height-1,room);
				ds_grid_set(grid,MAPENHANCER.ITEMID,height-1,inst.id);
				ds_grid_set(grid,MAPENHANCER.ITEMTYPE,height-1,ME_TYPE.ITEM);
				ds_grid_set(grid,MAPENHANCER.ITEMX,height-1,inst.x/room_width);
				ds_grid_set(grid,MAPENHANCER.ITEMY,height-1,inst.y/room_height);
			}
	}