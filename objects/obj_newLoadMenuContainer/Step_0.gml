/// @description

activated=(obj_mainMenuManager.activeMenu==Menu.NewGame or obj_mainMenuManager.activeMenu==Menu.LoadGame)	?	true	:	false;

var ease=true;
var snd=noone;
var len=array_length_1d(button);		//I use this mmultiple times

//Determine whether to ease or if we have already eased all the way
if (activated and timer==1)
	ease=false;
if (!activated and timer==0)
	ease=false;
	
var easeDir=(activated)	?	1	:	-1;

if (ease)	{
	//Change the header text if we're easing in only
	if (easeDir==1)
		headerText=(obj_mainMenuManager.activeMenu==Menu.NewGame)	?	scr_return_text(122)	:	scr_return_text(41);
	timer+=easeDir*0.015;
	timer=max(timer,0);
	timer=min(timer,1);
	//ease the buttons in
	var easingProportion=scr_easeInOutSin(timer);
	textAlpha=easingProportion;
	var active=activated;
	for (var i=0; i<len; i+=1)	{
		with (button[i])	{
			var buttonEasingProportion=easingProportion;
			if (active)
				buttonEasingProportion=min(1,easingProportion+0.4*(2-(y/270)));
			x=xstart-buttonEasingProportion*room_width+highlighted*28;
		}
	}
}

//Inputs
if (timer>0.9 and activated and !instance_exists(obj_transition))	{
	//inputs
	var select=global.inputs[4];
	var back=global.inputs[5];
	var vinput=-sign(global.inputs[1]);		//Take the sign so we don't get decimals
											//Also moving down is +1 and moving up is -1 so take the inversion
											
	//Do not do anything if we already have a confirmation box up AND if the confirmation box that exists is NOT active
	if (instance_exists(obj_confirmOverwrite) and (obj_confirmOverwrite.active or obj_confirmOverwrite.timer>0.9))	{
		select=0;
		back=0;
		vinput=0;
	}
	
	//Reset timer if released
	if (vinput==0)	{
		vinputCooldown=0;
		vinputClicks=0;
	}
	else	{
		//If we're at 0, move menu
		if (vinputCooldown==0)	{
			vinputClicks+=1;
			buttonSelected+=vinput;
			//Deal with button selections outside of range
			if (buttonSelected<0)
				buttonSelected+=len;
			else if (buttonSelected>=len)
				buttonSelected-=len;
			
			//Play a sound
			snd=audio_play_sound(snd_menu_move,0,false);
			
			chevron.attachedTo=button[buttonSelected];
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
	
	//Select and back behaviour
	//Select activated event_user(0) of the selected button
	if (select)	{
		snd=audio_play_sound(snd_menu_confirm,0,false);
		with (button[buttonSelected])
			event_user(0);
	}
		
	//Back goes back a menu
	if (back)	{
		snd=audio_play_sound(snd_menu_cancel,0,false);
		obj_mainMenuManager.activeMenu=Menu.Main;
	}
}

//Lerp the buttons instead their correct positions, but only if we're not easing
if (!ease and activated)	{
	var xx=xButtonTarget;
	for (var i=0; i<len; i+=1)	{
		//I think the "hightlighted" variable will end up useless, but regardless I'll go ahead with it
		button[i].highlighted=(buttonSelected==i)	?	true	:	false;
	
		//This moves the buttons to correct positions
		with (button[i])
			x=lerp(x,xx+highlighted*28,0.2);
	}
}

//Set any sound volumes correctly
if (snd!=noone)
	audio_sound_gain(snd,global.sound_fx_volume*global.sound_fx_on,0);