/// @description

if (global.hardpause or instance_exists(obj_transition) or global.softpause)
	exit;

draw_set_halign(fa_left);
draw_set_valign(fa_top);

//We get passed a string from somewhere else so once we have that we can set positions and shit
if (gottext==false and text!="")
	{
		gottext=true;
		text=string_upper(text);
		var _length=string_width(text);
		textxpos[0]=-_length*1.5;
		drawxpos=textxpos[0];
		textxpos[1]=display_get_gui_width()*0.5-_length*0.45;
		textxpos[2]=display_get_gui_width()*1.5;
		holdingtime=string_length(text)*4;
	}
	
//Early exit
if (gottext==false)
	{
		exit;
	}


//Move to centre of screen
if (state==0)
	{
		drawxpos=lerp(drawxpos,textxpos[1],lerpspeed);
		//Drift across the screen
		if (drifting==true)
			{
				drawxpos+=0.4;
			}
		if (abs(drawxpos-textxpos[1])<0.4 and drifting==false)
			{
				drawxpos=textxpos[1];
				state+=1;
				drifting=true;
			}
	}

//Wait a moment
if (state==1)
	{
		holdingtime-=1;
		if (holdingtime<=0)
			{
				state+=1;
			}
	}

//Go away again and destroy when no longer visible
if (state==2)
	{
		drawxpos=lerp(drawxpos,textxpos[2],lerpspeed);
		if (drawxpos>display_get_gui_width())
			{
				instance_destroy();
			}
	}