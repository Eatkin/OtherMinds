/// @description Draw self with shaders etc
// You can write your code in this editor

scr_iframes_draw();

//Now if we're in holding state we draw the object we're holding
if (state==PlayerState.holding)
	{
		var objsprite;
		var grid=global.inventory;
		var i;
		for (i=0;i<ds_grid_height(grid);i+=1)
			if (ds_grid_get(grid,INVENTORY.ITEMID,i)==holding)
				var objsprite=ds_grid_get(grid,INVENTORY.SPRITE,i);
				
		var _x=x+sprite_get_xoffset(objsprite)-sprite_get_width(objsprite)*0.5;
		var _y=32+sprite_get_yoffset(objsprite)-sprite_get_height(objsprite)*0.5;
		//Pos depending if we're upsidedown or not
		_y=(global.gravdirection==90)	?	y-_y-16	: y+_y;
		draw_sprite(objsprite,-1,_x,_y);
	}