/// @description 2 seconds before we can continue
// You can write your code in this editor

alarm[0]=120;
show_transition=true;

if (controller_global.firstgame==false)
	{
		alarm[0]=0;
		show_transition=false;
	}

controller_global.firstgame=false;

//Input array
options[OPTIONS.CONTROL,0]=scr_return_text(180);
options[OPTIONS.CONTROL,1]=scr_return_text(181);
options[OPTIONS.CONTROL,2]=scr_return_text(182);
options[OPTIONS.CONTROL,3]=scr_return_text(183);
options[OPTIONS.CONTROL,4]=scr_return_text(184);
options[OPTIONS.CONTROL,5]=scr_return_text(185);
options[OPTIONS.CONTROL,6]=scr_return_text(186);
options[OPTIONS.CONTROL,7]=scr_return_text(187);
numberofcontrols=8;

longestoptionlength=0;
for (var i=0; i<numberofcontrols; i+=1)
	{
		longestoptionlength=max(longestoptionlength,string_width(options[OPTIONS.CONTROL,i]));
	}

pressanykeyalpha=0;