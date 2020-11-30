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
	
	x=xstart-480*easingProportion;
}

//Behaviour here
if (timer>0.9 and active and !instance_exists(obj_transition))	{
	//inputs
	var select=global.inputs[4];
	var back=global.inputs[5];
	var vinput=-sign(global.inputs[1]);
	
	//Select
	if (select)	{
		//This will create a new box which will spontaneously appear because we don't want to mess around with animations for this
		//It will pass the key that is being rebound to the box so it knows which key to rebind
		//UNLESS you press restore defaults
		if (optionSelected==array_length_1d(option)-1)	{		//Restore defaults
			//Save inputs device and all associated variables, fully reset controls then restore variables
			var input=global.input;
			var detectedgamepad=global.hasdetectedgamepad;
			var pad=global.pad;
			scr_setup_input_array();
			global.input=input;
			global.hasdetectedgamepad=detectedgamepad;
			global.pad=pad;
		}
		else	{												//Create the key rebind thingy
			var panel=instance_create_layer(0,0,layer,obj_pauseKeyRebindPanel);
			panel.keyToRebind=optionSelected;				//Pass the key index
			panel.keyString=option[optionSelected];		//Pass the string
		}

			
		snd=audio_play_sound(snd_menu_confirm,0,false);
	}
	
	//We just go back with a back press
	if (back)	{
		snd=audio_play_sound(snd_menu_cancel,0,false);
		active=false;
		obj_pauseOptionsContainer.optionPanelActive=false;
		exit;
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