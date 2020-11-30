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
	timer+=easeDir*0.025;		//40 frame easing
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
	var vinput=-sign(global.inputs[1]);
	
	//Select
	if (select)	{
		//Enable/disable help bar or enable/disable vibration
		if (optionSelected==0)		//Help bar
			global.helpbar^=1;
		else if (optionSelected==2)	//Vibration
			global.vibration^=1;
			
		snd=audio_play_sound(snd_menu_confirm,0,false);
	}
	
	//We just go back with a back press
	if (back)	{
		snd=audio_play_sound(snd_menu_cancel,0,false);
		active=false;
		obj_optionsContainer.optionPanelActive=false;
		exit;
	}
	
	//Hinputs
	if (hinput==0)
		hinputPressed=false;
	else	{
		//hinputPressed does not indicate that hinput has been pressed
		//Rather, it indicates when it has been pressed and should no longer be responsive until it is released again
		if (!hinputPressed)	{
			var playMoveSound=false;
			var playNoSound=false;
			hinputPressed=true;

			//If difficulty is selected, we change it, else we say no
			if (optionSelected!=1)
				playNoSound=true;
			else	{
				//Change difficulty, check it's in bounds
				global.difficulty+=hinput;
				if (global.difficulty!=clamp(global.difficulty,DIFFICULTY.EXTRAEASY,DIFFICULTY.EXTRAHARD))	{
					playNoSound=true;
					global.difficulty=clamp(global.difficulty,DIFFICULTY.EXTRAEASY,DIFFICULTY.EXTRAHARD);
				}
				else
					playMoveSound=true;
			}
			
			if (playMoveSound)
				snd=audio_play_sound(snd_menu_move,0,false);
			if (playNoSound)
				snd=audio_play_sound(snd_menu_no,0,false);
		}
	}
	
	//Vinput - move up and down
	if (vinput==0)	{
		vinputCooldown=0;
		vinputClicks=0;
	}
	else	{
		var len=array_length_1d(option);
		//If we're at 0, move menu
		if (vinputCooldown==0)	{
			vinputClicks+=1;
			optionSelected+=vinput;
			//Deal with button selections outside of range
			if (optionSelected<0)
				optionSelected+=len;
			else if (optionSelected>=len)
				optionSelected-=len;
			
			//Play a sound
			snd=audio_play_sound(snd_menu_move,0,false);
		}
		
		vinputCooldown+=1;
		
		//If we hit vinputCooldownMax, reset cooldown to 0
		var maxCool=vinputCooldownMax;
		//If we're holding the button down, the first movement will take longer then subsequent movements are quicker
		if (vinputClicks>1)
			maxCool*=0.5;
			
		if (vinputCooldown==maxCool)
			vinputCooldown=0;
	}
}

//Lerp the chevron into position
//Lerp the x into pos
var chevronXPotential=x+17
chevronX=lerp(chevronX,chevronXPotential,0.2);

//Lerp the y into pos
var chevronYPotential=y+32+16*optionSelected;
chevronY=lerp(chevronY,chevronYPotential,0.2);

if (snd!=noone)
	audio_sound_gain(snd,global.sound_fx_volume*global.sound_fx_on,0);
	
//Update chevron timer
chevronTimer+=8;
chevronTimer%=360;