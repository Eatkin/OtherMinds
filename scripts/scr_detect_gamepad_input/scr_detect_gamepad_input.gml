//Created 08/09/19
//Last updated 08/09/19

//Loops through all gamepad constants and returns what it found
//Only goes up to pad r because I don't want you to define what tilting analog sticks does
for ( var i=gp_face1; i<=gp_padr; i+=1 )
	{
	    if gamepad_button_check_pressed(global.pad,i) //gamepad_button_check_pressed(global.pad,i) 
			{
				return i;
			}
	}

if gamepad_axis_value(global.pad,gp_axislh)<0
	{
		return gp_padl;
	}
if gamepad_axis_value(global.pad,gp_axislh)>0
	{
		return gp_padr;
	}
if gamepad_axis_value(global.pad,gp_axislv)<0
	{
		return gp_padu;
	}
if gamepad_axis_value(global.pad,gp_axislv)>0
	{
		return gp_padd;
	}

//Linux
if gamepad_button_check_pressed(global.pad,16)
	{
		return gp_select;
	}
return false;