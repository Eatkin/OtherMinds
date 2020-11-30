/// @description

//A modified version of drawing with shaders
//We have to modify because it's the child that gets hit
var _iframes=child.iframes
if _iframes>0
	{
		if _iframes%10<5
			{
				//my blacktowhite shader doesn't work for some reason but this is fine
				shader_set(shd_whitesprite);
				draw_self();
				shader_reset();
			}
		else
			{
				draw_self();
			}
	}
else
	{
		draw_self();
	}