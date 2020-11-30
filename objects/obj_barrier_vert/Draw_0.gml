/// @description Draw the barrier
// You can write your code in this editor

//I can apply a shader here to make it more red and less green or more white
//More red if Sage is close (i.e. reduce hue towards 0)
//More white if player is close (i.e. reduce saturation towards 0)

//Note here the barrier is rotated 270 degrees
//As origin is top left we need to translate the x position
if hueshift!=0 or satshift!=0
	{
		shader_set(shd_barrier);
		var huesatshift=shader_get_uniform(shd_barrier,"shad_huesatshift");
		shader_set_uniform_f(huesatshift,hueshift,satshift);
	}
if drawbarrier=1
	{
		var i;
		for (i=0;i<barrierrepeats;i+=1)
			{
				draw_sprite_ext(spr_barrier,-1,x+sprite_width,y+32*i,1,1,270,c_white,1);
			}
	}
else
	{
		i=barrierrepeats;
	}
if hueshift!=0 or satshift!=0
	{
		shader_reset();
	}
	
//Now draw the cannons
draw_sprite_ext(spr_barriercannon,0,x+sprite_width,y,1,1,270,c_white,1);
draw_sprite_ext(spr_barriercannon,0,x,y+32*i,1,1,90,c_white,1);