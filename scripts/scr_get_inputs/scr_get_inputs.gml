//Created: 23/05/19
//Last updated: 14/06/19

//layout
//[0   ,1    ,2  ,3   ,4,5,6       ,7     ,8 ,9 ,10,11,12,13,14   ,15    ,16] 
//[LS_H,LS_V,RS_H,RS_V,X,O,TRIANGLE,SQUARE,R1,R2,R3,L1,L2,L3,start,select,HOLDING JUMP, HOLDING SAGE, HOLDING ACTION]

//this is the exit operation for when we're rebinding a key
//It just blanks the array
if (instance_exists(obj_keyRebindPanel) or instance_exists(obj_pauseKeyRebindPanel))	{
	var len=array_length_1d(global.inputs);
	for (var i=0; i<len; i+=1)
		global.inputs[i]=0;
		
	exit;
}

var count=0; //Counter for how many keys are being pressed from what input device

//Set up temp variables to read inputs
var LS_H=0;
var LS_V=0;
var RS_H=0;
var RS_V=0;
var b_one=0;
var b_two=0;
var b_three=0;
var b_four=0;
var r_one=0;
var r_two=0;
var r_three=0;
var l_one=0;
var l_two=0;
var l_three=0;
var start=0;
var select=0;
var holding_b_one=0;
var holding_b_two=0;
var holding_b_three=0;
var holding_b_four=0;
var holding_start=false; //This is for skipping credits


//Get the keyboard inputs
LS_H=keyboard_check(global.kb_right)-keyboard_check(global.kb_left);
LS_V=keyboard_check(global.kb_up)-keyboard_check(global.kb_down);
RS_H=keyboard_check(global.kb_altright)-keyboard_check(global.kb_altleft);
RS_V=keyboard_check(global.kb_altup)-keyboard_check(global.kb_altdown);
b_one=keyboard_check_pressed(global.kb_b_one);
b_two=keyboard_check_pressed(global.kb_b_two);
b_three=keyboard_check_pressed(global.kb_b_three);
b_four=keyboard_check_pressed(global.kb_b_four);
r_one=keyboard_check_pressed(global.kb_r_one);
r_two=keyboard_check_pressed(global.kb_r_two);
r_three=keyboard_check_pressed(global.kb_r_three);
l_one=keyboard_check_pressed(global.kb_l_one);
l_two=keyboard_check_pressed(global.kb_l_two);
l_three=keyboard_check_pressed(global.kb_l_three);
start=max(keyboard_check_pressed(global.kb_start),keyboard_check_pressed(vk_escape));
select=keyboard_check_pressed(global.kb_select);
holding_b_one=keyboard_check(global.kb_b_one);
holding_b_two=keyboard_check(global.kb_b_two);
holding_b_three=keyboard_check(global.kb_b_three);
holding_b_four=keyboard_check(global.kb_b_four);
holding_start=max(keyboard_check(global.kb_start),keyboard_check(vk_escape));

//See if we should switch the input to a keyboard
count=abs(LS_H)+abs(LS_V)+abs(RS_H)+abs(RS_V)+b_one+b_two+b_three+b_four+r_one+r_two+r_three+l_one+r_two+r_three+l_one+l_two+l_three+start+select+holding_b_one+holding_b_two+holding_b_three+holding_b_four+holding_start;
if count!=0 and global.input!=keyboard
	{
		if global.pad!=-1
			{
				gamepad_set_vibration(global.pad,0,0);
			}
		global.input=keyboard;
	}

global.inputs[0]=LS_H;
global.inputs[1]=LS_V;
global.inputs[2]=RS_H;
global.inputs[3]=RS_V;
global.inputs[4]=b_one;
global.inputs[5]=b_two;
global.inputs[6]=b_three;
global.inputs[7]=b_four;
global.inputs[8]=r_one;
global.inputs[9]=r_two;
global.inputs[10]=r_three;
global.inputs[11]=l_one;
global.inputs[12]=l_two;
global.inputs[13]=l_three;
global.inputs[14]=start;
global.inputs[15]=select;
global.inputs[16]=holding_b_one;
global.inputs[17]=holding_b_two;
global.inputs[18]=holding_b_three;
global.inputs[19]=holding_b_four;
global.inputs[20]=holding_start;

if count>0
	{
		exit;
	}
count=0;

//If global.pad=-1 then no gamepad has been detected
if global.pad!=-1
	{
		LS_H=max(gamepad_axis_value(global.pad,gp_axislh),gamepad_button_check(global.pad,global.gp_right))+min(gamepad_axis_value(global.pad,gp_axislh),-gamepad_button_check(global.pad,global.gp_left));
		LS_V=max(-gamepad_axis_value(global.pad,gp_axislv),gamepad_button_check(global.pad,global.gp_up))+min(-gamepad_axis_value(global.pad,gp_axislv),-gamepad_button_check(global.pad,global.gp_down));
		RS_H=gamepad_axis_value(global.pad,gp_axisrh);
		RS_V=gamepad_axis_value(global.pad,gp_axisrv);
		b_one=gamepad_button_check_pressed(global.pad,global.gp_b_one);
		b_two=gamepad_button_check_pressed(global.pad,global.gp_b_two);
		b_three=gamepad_button_check_pressed(global.pad,global.gp_b_three);
		b_four=gamepad_button_check_pressed(global.pad,global.gp_b_four);
		r_one=gamepad_button_check_pressed(global.pad,global.gp_r_one);
		r_two=gamepad_button_check_pressed(global.pad,global.gp_r_two);
		r_three=gamepad_button_check_pressed(global.pad,global.gp_r_three);
		l_one=gamepad_button_check_pressed(global.pad,global.gp_l_one);
		l_two=gamepad_button_check_pressed(global.pad,global.gp_l_two);
		l_three=gamepad_button_check_pressed(global.pad,global.gp_l_three);
		start=gamepad_button_check_pressed(global.pad,global.gp_start);
		select=gamepad_button_check_pressed(global.pad,global.gp_select);
		holding_b_one=gamepad_button_check(global.pad,global.gp_b_one);
		holding_b_two=gamepad_button_check(global.pad,global.gp_b_two);
		holding_b_three=gamepad_button_check(global.pad,global.gp_b_three);
		holding_b_four=gamepad_button_check(global.pad,global.gp_b_four);
		holding_start=gamepad_button_check(global.pad,global.gp_start);
		
		//Linux because gp_select doesn't work for some reason lol
		if select=0
			{
				select=gamepad_button_check_pressed(global.pad,16);
			}
			
		//Adjust analog sticks because they're between global.deadzone and 1, we want them between 0 and 1
		//So -global.deadzone and divide by 1-global.deadzone?
		//Also make sure its not zero
		//I should not have to manually do this but needs must
		if (abs(LS_H)<global.deadzone)
			{
				LS_H=0;
			}
		if (abs(LS_V)<global.deadzone)
			{
				LS_V=0;
			}
		if (abs(RS_H)<global.deadzone)
			{
				RS_H=0;
			}
		if (abs(RS_V)<global.deadzone)
			{
				RS_V=0;
			}
			
		LS_H=(LS_H-sign(LS_H)*global.deadzone)/(1-global.deadzone);
		LS_V=(LS_V-sign(LS_V)*global.deadzone)/(1-global.deadzone);
		RS_H=(RS_H-sign(RS_H)*global.deadzone)/(1-global.deadzone);
		RS_V=(RS_V-sign(RS_V)*global.deadzone)/(1-global.deadzone);

		if global.input!=gamepad
			{
				count=abs(LS_H)+abs(LS_V)+abs(RS_H)+abs(RS_V)+b_one+b_two+b_three+b_four+r_one+r_two+r_three+l_one+r_two+r_three+l_one+l_two+l_three+start+select+holding_b_one+holding_b_two+holding_b_three+holding_b_four+holding_start;
				if count!=0
					{
						global.input=gamepad;
					}
			}
	}

//Now let us fill in that array
//Which is totally tedious because Gamemaker is a stupid piece of shit which could not possibly handle adding multiple array values at once
global.inputs[0]=LS_H;
global.inputs[1]=LS_V;
global.inputs[2]=RS_H;
global.inputs[3]=RS_V;
global.inputs[4]=b_one;
global.inputs[5]=b_two;
global.inputs[6]=b_three;
global.inputs[7]=b_four;
global.inputs[8]=r_one;
global.inputs[9]=r_two;
global.inputs[10]=r_three;
global.inputs[11]=l_one;
global.inputs[12]=l_two;
global.inputs[13]=l_three;
global.inputs[14]=start;
global.inputs[15]=select;
global.inputs[16]=holding_b_one;
global.inputs[17]=holding_b_two;
global.inputs[18]=holding_b_three;
global.inputs[19]=holding_b_four;
global.inputs[20]=holding_start;