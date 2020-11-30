/// @description

activated=(obj_mainMenuManager.activeMenu==Menu.Options)	?	true	:	false;

var ease=true;
var snd=noone;
var len=array_length_1d(button);		//I use this mmultiple times

//Okay this is really confusing because we now have to account for two seperate variables which control where it goes
//it has 3 positions: -1 0 1
//If inactive, in position 1
//If active, in position 0
//If active AND option panel active, in position -1
//Determine whether to ease or if we have already eased all the way
//So when option panel is active, we make an adjustment to the x position of (1-buttonEasingProportion)*room_width*2
//What the fuck am I doing
if ((activated and !optionPanelActive) and timer==1)
	ease=false;
if ((!activated or optionPanelActive) and timer==0)
	ease=false;
	
var easeDir=(activated and !optionPanelActive)	?	1	:	-1;
	
if (ease)	{
	timer+=easeDir*0.015;
	timer=max(timer,0);
	timer=min(timer,1);
	//ease the buttons in
	var easingProportion=scr_easeInOutSin(timer);
	var active=activated;
	var panelActive=optionPanelActive;
	var left=toTheLeft;
	for (var i=0; i<len; i+=1)	{
		with (button[i])	{
			var buttonEasingProportion=easingProportion;
			if (active)
				buttonEasingProportion=min(1,easingProportion+0.4*(2-(y/270)));
			//Some super serious jank ass code but it sure as heck works
			//Wait no it doesn't shit
			if (!panelActive and !left)
				x=xstart-buttonEasingProportion*room_width+highlighted*28;
			else
				x=xstart-2*room_width+buttonEasingProportion*room_width+highlighted*28;
		}
	}
}

//Stupid but whatever fuck off
if (timer>0.9 and !optionPanelActive)
	toTheLeft=false;

//Inputs
if (timer>0.9 and activated and !optionPanelActive and !instance_exists(obj_transition))	{
	//inputs
	var select=global.inputs[4];
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
	
	//This is going to cause bugs because you can press multiple buttons at once and not all sounds will be set to the correct volume
	//But fuck you
	//Now select
	if (select)	{
		with (button[buttonSelected])
			event_user(0);
			
		toTheLeft=true;
		
		snd=audio_play_sound(snd_menu_confirm,0,false);
	}
	
	//Back
	if (back)	{
		snd=audio_play_sound(snd_menu_cancel,0,false);
		obj_mainMenuManager.activeMenu=Menu.Main;
		exit;
	}
}

//Lerp the buttons instead their correct positions, but only if we're not easing
if (!ease and activated and !optionPanelActive)	{
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