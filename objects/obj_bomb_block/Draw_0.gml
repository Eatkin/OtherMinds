/// @description

if (whitesprite==true)
	{
		shader_set(shd_whitesprite);
		draw_self();
		shader_reset();
	}
else
	{
		draw_self();
	}