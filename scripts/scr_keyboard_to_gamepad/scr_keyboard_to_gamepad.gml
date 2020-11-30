//Created 26th June 2019
//Last updated 26th June 2019

//I didn't think of this earlier to use an array or something so I'm just going to write a script
//To swap out keyboard input for gamepad input


switch(argument0)
	{
		case global.kb_left:
			{
				return global.gp_left;
				break;
			}
		case global.kb_right:
			{
				return global.gp_right;
				break;
			}
		case global.kb_up:	
			{
				return global.gp_up;
				break;
			}
		case global.kb_down:
			{
				return global.gp_down;
				break;
			}
		case global.kb_altup:
			{
				return global.gp_altup;
				break;
			}
		case global.kb_altdown:
			{
				return global.gp_altdown;
				break;
			}
		case global.kb_altleft:
			{
				return global.gp_altleft;
				break;
			}
		case global.kb_altright:
			{
				return global.gp_altright;
				break;
			}
		case global.kb_b_one:
			{
				return global.gp_b_one;
				break;
			}
		case global.kb_b_two:
			{
				return global.gp_b_two;
				break;
			}
		case global.kb_b_three:
			{
				return global.gp_b_three;
				break;
			}
		case global.kb_b_four:
			{
				return global.gp_b_four;
				break;
			}
		case global.kb_r_one:
			{
				return global.gp_r_one;
				break;
			}
		case global.kb_r_two:
			{
				return global.gp_r_two;
				break;
			}
		case global.kb_r_three:
			{
				return global.gp_r_three;
				break;
			}
		case global.kb_l_one:
			{
				return global.gp_l_one;
				break;
			}
		case global.kb_l_two:
			{
				return global.gp_l_two;
				break;
			}
		case global.kb_l_three:
			{
				return global.gp_l_three;
				break;
			}
		case global.kb_start:
			{
				return global.gp_start;
				break;
			}
		case global.kb_select:
			{
				return global.gp_select;
				break;
			}
	}