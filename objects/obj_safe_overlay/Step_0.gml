/// @description

var snd=noone;

//Make sure we're pause because sometimes we have a bug where it doesn't pause for some reason
if global.softpause=false
	{
		global.softpause=true;
	}

//Gather inputs
var hinput=0;
var vinput=0;
var back=0;

if fadingin=false and fadingout=false and safeunlocked=false
	{
		hinput=global.inputs[0];
		vinput=global.inputs[1];
		back=global.inputs[7];
	}
	
if hinput=0 and vinput=0
	{
		tumblercooldown=min(tumblercooldown,5);
	}
	
if back=true
	{
		back=false;
		fadingout=true;
	}
	
//Manage loading everything in and out
if fadingin=true
	{
		var pass=0;
		//Lerp in the tumbler ys
		for (var i=0; i<4; i+=1)
			{
				tumblerydraw[i]=lerp(tumblerydraw[i],guiheight/2-8,0.5/(i+1));
				if abs(tumblerydraw[i]-(guiheight/2)+8)<1
					{
						tumblerydraw[i]=guiheight/2-8;
						pass+=1;
					}
			}
		//Lerp in the background
		backgroundalpha=lerp(backgroundalpha,backgroundalphamax,0.15);
		if abs(backgroundalpha-backgroundalphamax)<0.05
			{
				backgroundalpha=backgroundalphamax;
				pass+=1;
			}
		//Everything is in its right place
		if pass=5
			{
				fadingin=false;
			}
	}
//Opposite of above
if fadingout=true
	{
		var pass=0;
		//Lerp in the tumbler ys
		for (var i=0; i<4; i+=1)
			{
				tumblerydraw[i]=lerp(tumblerydraw[i],-guiheight/2,0.2/(4-i));
				if tumblerydraw[i]<-8
					{
						pass+=1;
					}
			}
		//Lerp in the background
		if backgroundalpha=backgroundalphamax
			{
				snd=audio_play_sound(sound_menuopen,0,false);
				audio_sound_pitch(snd,0.9);
			}
		backgroundalpha=lerp(backgroundalpha,0,0.15);
		if backgroundalpha<0.05
			{
				backgroundalpha=0
				pass+=1;
			}
		//Everything is in its right place
		if pass=5
			{
				instance_destroy();
			}
	}

//Set tumbler cool
tumblercooldown=max(0,tumblercooldown-1);

//Now lets control the tumblers - select tumbler
if hinput!=0 and tumblercooldown=0
	{
		tumblercooldown=tumblercooldownmax;
		tumblerselected+=sign(hinput);
		//Wrap
		if tumblerselected<0
			{
				tumblerselected=3;
			}
		tumblerselected=tumblerselected%4;
		snd=audio_play_sound(sound_changetumbler,0,false);
	}
	
//Change tumbler number
if vinput!=0 and tumblercooldown=0
	{
		tumblercooldown=tumblercooldownmax;
		tumbler[tumblerselected]-=sign(vinput);
		//Wrap
		if tumbler[tumblerselected]<0
			{
				tumbler[tumblerselected]=9;
			}
		tumbler[tumblerselected]=tumbler[tumblerselected]%10;
		snd=audio_play_sound(sound_tumblershift,0,false);
	}
	
//Now control the surf ys
for (var i=0; i<4; i+=1)
	{
		var surfytarget=(tumbler[i]+1)*16;
		//Now the exceptions, 0 and 9
		if tumbler[i]=0
			{
				if surfy[i]>32
					{
						surfytarget=176;
					}
			}
		if tumbler[i]=9
			{
				if surfy[i]<144
					{
						surfytarget=0;
					}
			}
		//Now the actual lerp
		surfy[i]=lerp(surfy[i],surfytarget,0.5);
		if abs(surfy[i]-surfytarget)<1
			{
				surfy[i]=surfytarget;
				//Then the two exceptions, wrap the surfaces
				if surfy[i]=176
					{
						surfy[i]=16;
					}
				if surfy[i]=0
					{
						surfy[i]=160;
					}
			}
	}


//If the tumblers are set to the correct combination
if tumbler[0]=2 and tumbler[1]=4 and tumbler[2]=0 and tumbler[3]=4
	{
		//Safe unlocked
		safeunlocked=true;
	}
if safeunlocked=true
	{
		//Add a short delay to the exit transition
		if alarm[0]=-1
			{
				snd=audio_play_sound(sound_safeunlock,0,false);
				//Here we set the alarm, change the safe
				alarm[0]=30;
				with (obj_safe)
					{
						instance_create_layer(x,y,layer,obj_safe_dud);
						instance_destroy();
					}
				//NOW SET THE EVENT TO TRIGGERED
				//WE ALSO PLAY THE SAFE OPENING SOUND
				global.edhouse_events=scr_event_set_complete(global.edhouse_events,EVENTS_EDHOUSE.OPENEDSAFE);
				with (global.currentinstance)
					{
						scr_todo_complete(4);
					}
			}
		if alarm[0]=0
			{
				alarm[0]=-2;
				fadingout=true;
				//HERE WE CREATE THE KEY
				if !instance_exists(obj_cellar_key)
					{
						var safe=obj_safe_dud;
						instance_create_layer(safe.x,safe.y,"objects",obj_cellar_key);
					}
			}
	}
	

//Now set the help bar here
//Also ned to update the HUD bar now
scr_HUD_tips_clear();
scr_HUD_set_tips_text(scr_return_text(258));
scr_HUD_set_tips_buttons(global.kb_b_four);

//Sound volume
if snd!=noone
	{
		audio_sound_gain(snd,global.sound_fx_volume*global.sound_fx_on,0);
	}