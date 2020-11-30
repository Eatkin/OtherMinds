/// @description

//Loop through and draw the texts! If they're offscreen, don't draw them
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(c_white);

var grid=creditsgrid;
var spacing=string_height("A")*1.5;

//Loop through until we hit a point where the y_pos>room_height then break the loop
for (var i=0; i<ds_grid_height(grid);i+=1)
	{
		var xdraw=ds_grid_get(grid,CREDITS.X_POS,i);
		var ydraw=ds_grid_get(grid,CREDITS.CURRENT_Y_POS,i);
		if ydraw>room_height+spacing
			{
				break;
			}
		if ydraw<-spacing
			{
				continue;
			}
		var text=ds_grid_get(grid,CREDITS.WORD,i);
		draw_text(xdraw,ydraw,text);
	}
	
//Draw skipping timer tetx
if (holdingtoskip==false)
	{
		exit;
	}

var text=scr_return_text(439);
var textwidth=string_width(text);
draw_text((room_width-textwidth)*0.5,room_height-36,scr_return_text(439));
var number=ceil(skippingtimer/room_speed);
textwidth=string_width(number);
draw_text((room_width-textwidth)*0.5,room_height-18,number);