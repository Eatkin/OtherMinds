/// @description Draw the barrier
// You can write your code in this editor

//I can apply a shader here to make it more red and less green or more white
//More red if Sage is close (i.e. reduce hue towards 0)
//More white if player is close (i.e. reduce saturation towards 0)
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
				draw_sprite(spr_barrier,-1,x+32*i,y);
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
draw_sprite(spr_barriercannon,0,x,y);
draw_sprite_ext(spr_barriercannon,0,x+32*i,y,-1,1,0,c_white,1);