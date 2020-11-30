//Created: 23/05/19
//Last updated: 19/06/19

//This creates a global array for gathering inputs from keyboard or controller

//I'm setting up 14 inputs to match how many inputs a controller would be able to define
//But also there's extra for if an input is being held
//These variables are for easy readability
keyboard=1;
gamepad=2;
global.input=1;
global.deadzone=0.25;
global.pad=-1;
global.hasdetectedgamepad=false;


var i;
for (i=0;i<21;i+=1)
	{
		global.inputs[i]=0;
	}
	
//So here's the layout I will do
//[LS_H,LS_V,RS_H,RS_V,X,O,TRIANGLE,SQUARE,R1,R2,R3,L1,L2,L3,START,SELECT,HOLDING X]

/*LS_H etc will return a value between -1 and 1
For simplicity that means the keyboard keys and dpad inputs will both just set these values to -1 or 1
*/

//Now i'll set up some generic variable names to say what the buttons are called
global.kb_left=vk_left;
global.kb_right=vk_right;
global.kb_up=vk_up;
global.kb_down=vk_down;
global.kb_altup=ord("W");
global.kb_altdown=ord("S");
global.kb_altleft=ord("A");
global.kb_altright=ord("D");
global.kb_b_one=ord("Z");
global.kb_b_two=ord("X");
global.kb_b_three=ord("V");
global.kb_b_four=ord("C");
global.kb_r_one=ord("P");
global.kb_r_two=ord("I");
global.kb_r_three=ord("U");
global.kb_l_one=ord("Q");
global.kb_l_two=ord("E");
global.kb_l_three=ord("R");
global.kb_start=vk_enter;
global.kb_select=vk_backspace;

//Gamepad input
//The directional control is locked because only a complete idiot would ever want to change them
global.gp_left=gp_padl;
global.gp_right=gp_padr;
global.gp_up=gp_padu;
global.gp_down=gp_padd;
//Start and select are also locked
global.gp_b_one=gp_face1;
global.gp_b_two=gp_face2;
global.gp_b_three=gp_face4; //how confusing
global.gp_b_four=gp_face3;
global.gp_r_one=gp_shoulderr;
global.gp_r_two=gp_shoulderrb;
global.gp_r_three=gp_stickr;
global.gp_l_one=gp_shoulderl;
global.gp_l_two=gp_shoulderlb;
global.gp_l_three=gp_stickl;
global.gp_start=gp_start;
global.gp_select=gp_select;