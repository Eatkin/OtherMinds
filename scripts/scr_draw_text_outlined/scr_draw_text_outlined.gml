//Draws white text with a black outline
//Well apart from it doesn't really work because it makes the whole font 2 pixels wider
//Whereas actually it could do with drawing 1px shifted in every direction
//More gives it a shadow

var xdraw=argument0;
var ydraw=argument1;
var texttodraw=argument2;

draw_set_colour(c_black);
for (var i=-1; i<=1; i+=1)
	{
		for (var j=-1; j<=1; j+=1)
			{
				draw_text(xdraw+i,ydraw+j,texttodraw);
			}
	}
	
draw_set_colour(c_white);
draw_text(xdraw,ydraw,texttodraw);