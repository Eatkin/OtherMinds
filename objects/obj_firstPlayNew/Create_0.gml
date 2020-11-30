/// @description
// You can write your code in this editor
	
scr_create_transition(0,TRANSITION.FADE_OUT);

canMove=false;
transitioningOut=false;

menuTab=0;
menuText[0,0]=scr_return_text(18); //Gamepad style (text 51-53 for xbox, PS, nintendo)
menuText[1,0]=scr_return_text(573); //Use keyboard

//Difficulty
menuText[0,1]=scr_return_text(574); //Weenie
menuText[1,1]=scr_return_text(61);	//Easy
menuText[2,1]=scr_return_text(575);	//Normal
menuText[3,1]=scr_return_text(62);	//Hard
menuText[4,1]=scr_return_text(63);	//Super hard

//Hold menu selections in an array
selection[0]=0;
selection[1]=2;
//Also set maxselection
maxSelection[0]=1;
maxSelection[1]=4;

//Difficulty descriptions
for (var i=0; i<5; i+=1)
	{
		menuText[i,2]=scr_return_text(576+i);
	}
	
//Some text shit
v_spacing=18;

moveCooldownMax=10;
moveCooldown=0;

//Cursor positions RELATIVE!!
cursor[0,0]=-string_width(menuText[0,0])*0.5-v_spacing; //x
cursor[0,1]=0; //y
cursor[1,0]=-string_width(menuText[1,0])*0.5-v_spacing;
cursor[1,1]=0;

myTransition=noone;

//Decalre difficulty surfacee;
difficultySurface=noone;
difficultySurfY=0;

notificationShown=false;