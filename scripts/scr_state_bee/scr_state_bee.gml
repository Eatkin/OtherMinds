//Created 20/02/20
//Last updated 20/02/20

//Controls for if you are a bee!

var holdingjumpinput=global.inputs[16];
var hinput=global.inputs[0];
var vinput=global.inputs[1];
var b_four=global.inputs[7];

if canmove=0
	{
		holdingjumpinput=s_jumphold;
		hinput=s_hinput;
		vinput=s_vinput;
		b_four=s_b_four;
	}
	
//So we move about normally, holding jump rises you up
//Holding up halts you falling

//Gather inputs
if hinput!=0
	{
		//add acceleration
		if smoothaccelerationenabled=true
			{
				scr_add_xacceleration_smooth(hinput);
			}
		else
			{
				scr_add_xacceleration_linear(hinput);
			}
	}
else if decelerationenabled=true
	{
		//Reduce speed - if we stop, go to idle
		if smoothaccelerationenabled=true
			{
				scr_subtract_xacceleration_smooth();
			}
		else
			{
				scr_subtract_xacceleration_linear();
			}
	}
	
//Move
scr_xmove_loop(hinput);

if (holdingjumpinput==true)
	{
		yspeed-=0.2;
	}

yspeed=clamp(yspeed,-maxyspeed,maxyspeed);
	
//Now handle gravity

var _g=global.gravstrength*0.1;
//This stops the weird looking sudden switch between yspeed=1 to yspeed=-1
if yspeed=clamp(yspeed,0,1) and holdingjumpinput=false
	{
		_g*=3;
	}
if vinput>0 and yspeed>=0
	{
		yspeed=lerp(yspeed,(1-vinput)*_g,0.1);
		if abs(yspeed)<0.1
			{
				yspeed=0;
			}
	}
else if vinput<0
	{
		yspeed+=_g*(1+abs(vinput));
	}
else
	{
		yspeed+=_g;
	}
if yspeed>0
	{
		yspeed=clamp(yspeed,0,maxyspeed);
	}
	
//Ymove loop
var repeats=floor(abs(yspeed));
repeat(repeats)
	{
		if y<-120 and yspeed<0
			{
				yspeed=max(yspeed,0);
			}
		//Move
		if !place_meeting(x,y+sign(yspeed),obj_solid) or interactwithblocksenabled=false
			{
				y+=sign(yspeed);
			}
		else
			{
				yspeed=0;
				break;
			}
	}
	
//Shooting
if (shootingenabled==true)
	{
		if (b_four==true and guncooldown==0)
			{
				var xcreate=x+gunxoffset*directionfacing;
				var ycreate=y+gunyoffset;
				var bee=instance_create_layer(xcreate,ycreate,"objects",obj_beeball);
				var smoke=instance_create_layer(xcreate,ycreate,"objects",obj_smokering);
				smoke.image_xscale=directionfacing;
				bee.xspeed=bee.maxspeed*directionfacing;
				bee.image_xscale=directionfacing;
				xspeed-=gunrecoil*directionfacing;
				guncooldown=guncooldownmax+1;
				var snd=instance_create_layer(xcreate,ycreate,layer,obj_sound_emitter);
				snd.soundid=snd_shoot;
			}

		guncooldown=max(guncooldown-1,0);
	}