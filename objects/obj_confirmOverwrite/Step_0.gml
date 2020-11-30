/// @description ease in/Out and behaviour

var ease=true;
var snd=noone;

if (active and timer==1)
	ease=false;
//Destroy when off screen
if (!active and timer==0)	{
	instance_destroy();
	exit;
}
	
var easeDir=(active)	?	1	:	-1;

//Easing
if (ease)	{
	timer+=easeDir*0.05;		//20 frame easing
	timer=max(timer,0);
	timer=min(timer,1);
	//ease the buttons in
	var easingProportion=scr_easeInOutSin(timer);
	
	x=xstart-room_width*easingProportion;
}

//Behaviour here
if (timer>0.9 and active and !instance_exists(obj_transition))	{
	//inputs
	var select=global.inputs[4];
	var back=global.inputs[5];
	var hinput=sign(global.inputs[0]);
	
	//Select
	if (select)	{
		//If we select back just execute the samebehaviour as pressing back
		if (optionSelected==1)
			back=true;
		else										//Otherwise we overwrite the game!!
			scr_newGameFromMenu(linkedGame);
	}
	
	//We just go back with a back press
	if (back)	{
		snd=audio_play_sound(snd_menu_cancel,0,false);
		active=false;
		exit;
	}
	
	//Hinputs
	if (hinput==0)
		hinputPressed=false;
	else	{

		if (!hinputPressed)	{
			var playMoveSound=false;
			var playNoSound=false;
			hinputPressed=true;
			
			//Move right
			if (hinput==1)	{
				if (optionSelected==0)	{
					optionSelected=1;
					playMoveSound=true;
				}
				else
					playNoSound=true;
			}
			
			//Move left
			if (hinput==-1)	{
				if (optionSelected==1)	{
					optionSelected=0;
					playMoveSound=true;
				}
				else
					playNoSound=true;
			}
			
			if (playMoveSound)
				snd=audio_play_sound(snd_menu_move,0,false);
			if (playNoSound)
				snd=audio_play_sound(snd_menu_no,0,false);
		}
	}
	
	
}

//Lerp the chevron into position
//Also update positions if we're easing
if (ease)	{
	chevronXPotential[0]=x+17
	chevronXPotential[1]=x+hrepeats*16-65-string_width(option[1]);
}
chevronX=lerp(chevronX,chevronXPotential[optionSelected],0.2);

if (snd!=noone)
	audio_sound_gain(snd,global.sound_fx_volume*global.sound_fx_on,0);
	
//Update chevron timer
chevronTimer+=8;
chevronTimer%=360;