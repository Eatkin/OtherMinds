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
	var hinput=sign(global.inputs[0]);
	var vinput=-sign(global.inputs[1]);
	
	//Select
	if (select)	{
		//Enable/disable things
		if (optionSelected==0)			//Enable sound
			global.sound_fx_on^=1;
		else if (optionSelected==1)	{	//Enable music
			global.music_on^=1;
			with (obj_music)
				if (nowplaying!=noone)
					audio_sound_gain(nowplaying,global.music_volume*global.music_on,0);							
		}
		else if (optionSelected==2)		//3d sound
			global.sound_3d^=1;

			
		snd=audio_play_sound(snd_menu_confirm,0,false);
	}
	
	//We just go back with a back press
	if (back)	{
		snd=audio_play_sound(snd_menu_cancel,0,false);
		active=false;
		obj_pauseOptionsContainer.optionPanelActive=false;
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

			if (optionSelected==3)	{		//Sound volume
				global.sound_fx_volume+=0.1*sign(hinput)*global.sound_fx_on;
				if (global.sound_fx_volume==clamp(global.sound_fx_volume,0,1) and global.sound_fx_on)
					playMoveSound=true;
				else
					playNoSound=true;

				global.sound_fx_volume=clamp(global.sound_fx_volume,0,1);
			}
			else if (optionSelected=4)	{		//Music volume
				global.music_volume+=0.1*sign(hinput)*global.music_on;
				if (global.music_volume==clamp(global.music_volume,0,1) and global.music_on)
					playMoveSound=true;
				else
					playNoSound=true;

				global.music_volume=clamp(global.music_volume,0,1);
				with (obj_music)
					if (nowplaying!=noone)
						audio_sound_gain(nowplaying,global.music_volume*global.music_on,0);

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