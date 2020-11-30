//Created 01/10/19
//Last update 01/10/19

//We will create the default transition
//Argument0 will be T_IN or T_OUT
//Argument1 is optional - it will override the default transition stored in global.transitions

var trans=instance_create_layer(x,y,"Controllers",obj_transition);
if argument_count>1
	{
		trans.transition_type=argument[1];
	}
else
	{
		//None
		if (global.transitions==0)
			{
				trans.transition_type=TRANSITION.T_NONE_IN;
			}
		//Circle
		else if global.transitions=1
			{
				trans.transition_type=TRANSITION.CIRCLE_IN;
			}
		//Fade
		else if global.transitions=2
			{
				trans.transition_type=TRANSITION.FADE_IN;
			}
		if argument[0]=TRANSITION.T_OUT
			{
				trans.transition_type+=1;
			}
	}
	
return trans;