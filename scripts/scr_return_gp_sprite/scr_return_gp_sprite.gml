//created 25th June 2019
//Last updated 25th June 2019

//Gets input and returns sprite
var input=argument0;
var sprite=spr_unknowninput;

#region xbox
if global.gamepadtype=PAD.XBOX
	{
		switch (input)
			{
				case gp_face1:
					{
						sprite=spr_a_button;
						break;
					}
				case gp_face2:
					{
						sprite=spr_b_button;
						break;
					}
				case gp_face3:
					{
						sprite=spr_x_button;
						break;
					}
				case gp_face4:
					{
						sprite=spr_y_button;
						break;
					}
				case gp_shoulderl:
					{
						sprite=spr_lb;
						break;
					}
				case gp_shoulderlb:
					{
						sprite=spr_lt;
						break;
					}
				case gp_shoulderr:
					{
						sprite=spr_rb;
						break;
					}
				case gp_shoulderrb:
					{
						sprite=spr_rt;
						break;
					}
				case gp_start:
					{
						sprite=spr_start;
						break;
					}
				case gp_select:
					{
						sprite=spr_select;
						break;
					}
				case gp_stickl:
					{
						sprite=spr_ls;
						break;
					}
				case gp_stickr:
					{
						sprite=spr_rs;
						break;
					}
				case gp_padu:
					{
						sprite=spr_dpad_up;
						break;
					}
				case gp_padd:
					{
						sprite=spr_dpad_down;
						break;
					}
				case gp_padl:
					{
						sprite=spr_dpad_left;
						break;
					}
				case gp_padr:
					{
						sprite=spr_dpad_right;
						break;
					}
			}
	}
#endregion

#region PS
if global.gamepadtype=PAD.PS
	{
		switch (input)
			{
				case gp_face1:
					{
						sprite=spr_x_button_ps;
						break;
					}
				case gp_face2:
					{
						sprite=spr_circle_button;
						break;
					}
				case gp_face3:
					{
						sprite=spr_square_button;
						break;
					}
				case gp_face4:
					{
						sprite=spr_triangle_button;
						break;
					}
				case gp_shoulderl:
					{
						sprite=spr_L1;
						break;
					}
				case gp_shoulderlb:
					{
						sprite=spr_L2;
						break;
					}
				case gp_shoulderr:
					{
						sprite=spr_R1;
						break;
					}
				case gp_shoulderrb:
					{
						sprite=spr_R2;
						break;
					}
				case gp_start:
					{
						sprite=spr_startps;
						break;
					}
				case gp_select:
					{
						sprite=spr_selectps;
						break;
					}
				case gp_stickl:
					{
						sprite=spr_ls;
						break;
					}
				case gp_stickr:
					{
						sprite=spr_rs;
						break;
					}
				case gp_padu:
					{
						sprite=spr_dpad_up;
						break;
					}
				case gp_padd:
					{
						sprite=spr_dpad_down;
						break;
					}
				case gp_padl:
					{
						sprite=spr_dpad_left;
						break;
					}
				case gp_padr:
					{
						sprite=spr_dpad_right;
						break;
					}
			}
	}
#endregion

#region Nintendo
if global.gamepadtype=PAD.NINTENDO
	{
		switch (input)
			{
				case gp_face1:
					{
						sprite=spr_b_nin;
						break;
					}
				case gp_face2:
					{
						sprite=spr_a_nin;
						break;
					}
				case gp_face3:
					{
						sprite=spr_y_nin;
						break;
					}
				case gp_face4:
					{
						sprite=spr_x_nin;
						break;
					}
				case gp_shoulderl:
					{
						sprite=spr_nin_L;
						break;
					}
				case gp_shoulderlb:
					{
						sprite=spr_nin_ZL;
						break;
					}
				case gp_shoulderr:
					{
						sprite=spr_nin_R;
						break;
					}
				case gp_shoulderrb:
					{
						sprite=spr_nin_ZR;
						break;
					}
				case gp_start:
					{
						sprite=spr_nin_plus;
						break;
					}
				case gp_select:
					{
						sprite=spr_nin_minus;
						break;
					}
				case gp_stickl:
					{
						sprite=spr_ls;
						break;
					}
				case gp_stickr:
					{
						sprite=spr_rs;
						break;
					}
				case gp_padu:
					{
						sprite=spr_dpad_up;
						break;
					}
				case gp_padd:
					{
						sprite=spr_dpad_down;
						break;
					}
				case gp_padl:
					{
						sprite=spr_dpad_left;
						break;
					}
				case gp_padr:
					{
						sprite=spr_dpad_right;
						break;
					}
			}
	}
#endregion

return sprite;