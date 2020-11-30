/// @description

activated=(obj_pauseMenuManager.activeMenu==PauseMenu.Inventory)	?	true	:	false;

var ease=true;
var snd=noone;
var len=array_length_1d(button);		//I use this mmultiple times

//Determine whether to ease or if we have already eased all the way
if (activated and timer==1)
	ease=false;
if (!activated and timer==0)	{
	ease=false;
	//Reset the menu position
	button[buttonSelected].highlighted=false;
	buttonSelected=0;
	button[buttonSelected].highlighted=true;
}
	
var easeDir=(activated)	?	1	:	-1;
	
if (ease)	{
	timer+=easeDir*0.025;
	timer=max(timer,0);
	timer=min(timer,1);
	//ease the buttons in
	var easingProportion=scr_easeInOutSin(timer);
	var active=activated;
	for (var i=0; i<len; i+=1)	{
		with (button[i])	{
			var buttonEasingProportion=easingProportion;
			if (active)
				buttonEasingProportion=min(1,easingProportion+0.1*(1-(y/270)));
			x=xstart-buttonEasingProportion*480+highlighted*28;
		}
	}
	
	//Now ease the arrows
	for (var i=0; i<2; i+=1)
		with (arrow[i])
			x=xstart-480*easingProportion;
}

//Inputs
if (timer>0.9 and activated and !instance_exists(obj_transition))	{
	//inputs
	//var select=global.inputs[4];
	var back=global.inputs[5];
	var vinput=-sign(global.inputs[1]);		//Take the sign so we don't get decimals
											//Also moving down is +1 and moving up is -1 so take the inversion
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
			
			chevron.attachedTo=button[buttonSelected];
			
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
	
	//Back (back to the menu)
	if (back)	{
		snd=audio_play_sound(snd_menu_cancel,0,false);
		obj_pauseMenuManager.activeMenu=PauseMenu.Main;
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

//Now we will manage the scrolling
//If we are below the bottom we scroll down
if (buttonSelected>buttonsPerScreen+menuyOffset)	{
	menuyOffset=buttonSelected-buttonsPerScreen;
	//Fade in top arrow icon
	arrow[0].alpha=1;
	//If at the bottom, fade out bottom arrow icon
	if (buttonSelected==len-1)
		arrow[1].alpha=0;
}

//If we are above the top, scroll up
if (buttonSelected<menuyOffset)	{
	menuyOffset=buttonSelected;
	//Fade in bottom arrow
	arrow[1].alpha=1;
	//Fade out top arrow
	if (buttonSelected==0)
		arrow[0].alpha=0;
}
	
//Now loop through the buttons to scroll all of them to the correct position
var offset=menuyOffset*buttonSpacing;
for (var i=0; i<len; i+=1)
	with (button[i])
		y=lerp(y,ystart-offset,0.2);

//Set any sound volumes correctly
if (snd!=noone)
	audio_sound_gain(snd,global.sound_fx_volume*global.sound_fx_on,0);