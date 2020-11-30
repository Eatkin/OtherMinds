/// @description

if (global.hardpause)
	{
		haspaused=true;
		exit;
	}
//Resync music
if (haspaused)
	{
		audio_sound_set_track_position(theMusic,(counter/60)+musicOffset);
		haspaused=false;
		audio_sound_gain(theMusic,global.music_volume*global.music_on,0);
	}

//timeline_position=counter;
counter+=1;
position=floor(counter/24);

if (counter>0 and counter==counter+counter%24 and audio_is_playing(theMusic))
	with (parent_main_character)
		instance_create_layer(x,y,layer,obj_quaver);

//Stuff
switch (counter)	{
	case 24:
		inst_4B5C6145.activated=true;
		inst_4B5C6145.timer=0;
		break;
	//Shoot cannons
	case 192:
		inst_79ED9A19.activated=true;
		break;
	case 193:
		inst_79ED9A19.activated=false;
		break;
	case 216:
		inst_2DC99A0D.activated=true;
		break;
	case 217:
		inst_2DC99A0D.activated=false;
		break;
	case 240:
		inst_190DA7DA.activated=true;
		break;
	case 241:
		inst_190DA7DA.activated=false;
		break;
	
	case 336:
		with (obj_warningScreen)	{
			staticTimer=staticTimerMax;
			tvSprite=spr_spikesScreen;
		}
		break;
	
	//Floor spikes
	case 384:
		with (obj_gauntlet_popoutspikes)
			activated=true;
		break;
	
	//Shoot cannons
	case 408:
		inst_79ED9A19.activated=true;
		break;
	case 409:
		inst_79ED9A19.activated=false;
		break;
	case 432:
		inst_2DC99A0D.activated=true;
		break;
	case 433:
		inst_2DC99A0D.activated=false;
		break;
	//deactivate spikes
	//Warn lasers and saw
	case 456:
		inst_190DA7DA.activated=true;
		with (obj_gauntlet_popoutspikes)
			activated=false;
		with (obj_warningScreen)	{
			staticTimer=staticTimerMax;
			if (x>=336)
				tvSprite=spr_laserScreen;
			else
				tvSprite=spr_sawScreen;
		}
		break;
	case 457:
		inst_190DA7DA.activated=false;
		break;
		
	//activate laser and saw
	case 528:
		inst_1825F0F.maxspeed=2;
		inst_39A5B5C0.maxspeed=2;
		break;
	
	//72 frame warning
	//Laser warning
	case 636:
		with (obj_warningScreen)
			if (y<=64)	{
				staticTimer=staticTimerMax;
				tvSprite=spr_laserScreen;
			}
		break;
	//Saw warning
	case 684:
		with (obj_warningScreen)
			if (y>64)	{
				staticTimer=staticTimerMax;
				tvSprite=spr_sawScreen;
			}
		break;
	
	//Fast laser
	case 708:
		inst_53C5CB19.maxspeed=4;
		break;
	//Fast saw
	case 756:
		inst_53B0F00D.maxspeed=4;
		break;
	
	//Start spikes warnings
	//One
	case 804:
		with (inst_23C15643)	{
			staticTimer=staticTimerMax;
			tvSprite=spr_spikesScreen;
		}
		break;
	//Two
	case 828:
		with (inst_6DDF2828)	{
			staticTimer=staticTimerMax;
			tvSprite=spr_spikesScreen;
		}
		break;
	//Eject spikes start
	//Three
	case 852:
		with (inst_1B148394)	{
			staticTimer=staticTimerMax;
			tvSprite=spr_spikesScreen;
		}
		with (obj_gauntlet_popoutspikes)
			if (x==32)
				activated=true;
		break;
	case 876:
	//Four
		with (obj_gauntlet_popoutspikes)
			if (x==464)
				activated=true;
		with (inst_73688F00)	{
			staticTimer=staticTimerMax;
			tvSprite=spr_spikesScreen;
		}
		break;
	
	//Continue spikes
	//Start warnings again double time
	//One
	case 900:
		with (inst_23C15643)	{
			staticTimer=staticTimerMax;
			tvSprite=spr_spikesScreen;
		}
		with (obj_gauntlet_popoutspikes)
			if (x==48)
				activated=true;
		break;
	//Two
	case 912:
		with (inst_6DDF2828)	{
			staticTimer=staticTimerMax;
			tvSprite=spr_spikesScreen;
		}
		break;
	//Three
	case 924:
		with (inst_1B148394)	{
			staticTimer=staticTimerMax;
			tvSprite=spr_spikesScreen;
		}
		with (obj_gauntlet_popoutspikes)
			if (x==448)
				activated=true;
		break;
	//Four
	case 948:
		with (inst_73688F00)	{
			staticTimer=staticTimerMax;
			tvSprite=spr_spikesScreen;
		}
		with (obj_gauntlet_popoutspikes)
			if (x==64)
				activated=true;
		break;
	case 972:
		with (obj_gauntlet_popoutspikes)
			if (x==432)
				activated=true;
		break;
	case 996:
		with (obj_gauntlet_popoutspikes)
			if (x==80)
				activated=true;
		break;
	case 1020:
		with (obj_gauntlet_popoutspikes)
			if (x==416)
				activated=true;
		break;
	
	//Shoot off cannons so there's something to do
	case 1032:
		inst_79ED9A19.activated=true;
		break;
	case 1033:
		inst_79ED9A19.activated=false;
		break;
	
	//Start retracting before fast retract
	case 1044:
		with (obj_gauntlet_popoutspikes)
			if (x==80 or x==416)
				activated=false;
		break;
		
	//Cannons
	case 1056:
		inst_2DC99A0D.activated=true;
		break;
	case 1057:
		inst_2DC99A0D.activated=false;
		break;
	
	//More spikes retract
	case 1068:
		with (obj_gauntlet_popoutspikes)
			if (x==64 or x==432)
				activated=false;
		break;
	
	//More cannons
	case 1080:
		inst_190DA7DA.activated=true;
		break;
	case 1081:
		inst_190DA7DA.activated=false;
		break;
		
	case 1092:
		with (obj_gauntlet_popoutspikes)
			if (x==48 or x==448)
				activated=false;
		break;
		
	//Final cannons
	case 1104:
		inst_2DC99A0D.activated=true;
		break;
	case 1105:
		inst_2DC99A0D.activated=false;
		break;
		
	//Wwarn about spikes again (big warning)
	case 1126:
		with(obj_warningScreen)	{
			staticTimer=staticTimerMax;
			tvSprite=spr_spikesScreen;
		}
		with (obj_gauntlet_popoutspikes)
			if (x==32 or x==464)
				activated=false;
		break;
	
	//Frame 1152 is where music speeds up
	//Also delete the central spikes and halt momentum of saws and lasers
	//BEAT ONE
	case 1152:
		with (obj_gauntlet_popoutspikes)	{
			if (x==32 or x==464)
				activated=true;
				
			if (x==clamp(x,208,272) and y<416)		//Arbitrary y
				instance_destroy();
		}
		//Halt laser
		with (inst_1825F0F)
			maxspeed=0;
		//Halt saw
		with (inst_39A5B5C0)
			maxspeed=0;
		//ALSO delete all the snake block arrows so they disappear
		with (obj_arrow_outline)
			instance_destroy();
		break;
	case 1164:
		with (obj_gauntlet_popoutspikes)
			if (x==48 or x==448)
				activated=true;
		break;
	//BEAT TWO
	case 1176:
		with (obj_gauntlet_popoutspikes)
			if (x==64 or x==432)
				activated=true;
		break;
	case 1188:
		with (obj_gauntlet_popoutspikes)
			if (x==80 or x==416)
				activated=true;
		break;
	//BEAT THREE
	case 1200:
		with (obj_gauntlet_popoutspikes)
			if (x==96 or x==400)
				activated=true;
		break;
	case 1212:
		with (obj_gauntlet_popoutspikes)
			if (x==112 or x==384)
				activated=true;
		break;
	//BEAT FOUR
	case 1224:
		with (obj_gauntlet_popoutspikes)
			if (x==128 or x==368)
				activated=true;
		break;
	case 1236:
		with (obj_gauntlet_popoutspikes)
			if (x==144 or x==352)
				activated=true;
		break;
	//BEAT FIVE
	//Do nothing
	//On beat 55 (total) eject the remaining spikes
	case 1320:
		with(obj_gauntlet_popoutspikes)
			activated=true;
		break;
	
	case 1416:
		with(obj_gauntlet_popoutspikes)
			activated=false;
		break;
	//Beat 60 we do the duh DUH duh duh DUH du
	//Duh (left)
	case 1440:
		with(obj_gauntlet_popoutspikes)
			if (x<208)
				activated=true;
		break;
	//DUH (right)
	case 1464:
		with(obj_gauntlet_popoutspikes)
			if (x>208)
				activated=true;
			else
				activated=false;
		break;
	//duh- (left left)
	case 1488:
		with(obj_gauntlet_popoutspikes)
			if (x<96)
				activated=true;
			else
				activated=false;
		break;
	//-duh (left right)
	case 1500:
		with(obj_gauntlet_popoutspikes)
			if (x<208)
				activated=true;
		break;
	//DUH (right left)
	case 1512:
		with(obj_gauntlet_popoutspikes)
			if (x==clamp(x,209,368))
				activated=true;
		break;
	//Platform drop and release camera
	//DUH (all)
	case 1524:
		with (obj_gauntlet_popoutspikes)
			activated=true;
		scr_regionunlock();
		with (inst_396159FF)
			activated=true;
		break;
	
	//We can work out the platform's y at any point and actived/deactivate as we wish
	//The platform can do several drops then we can have a laser chase or something 
	//It falls 300 units in 24 frames
	//In 13 frames, it falls about 96 units, which is a tolerable error margin (actually 91)
	//That means every 2 falls it will be 10 units behind, so the 3rd fall can be 14 frames
	
	case 1537:
		with (inst_396159FF)
			activated=false;
		break;
	
	//Fall 2
	case 1572:
		with (inst_396159FF)
			activated=true;
		break;
	case 1585:
		with (inst_396159FF)
			activated=false;
		break;
		
	//Fall 3
	case 1620:
		with (inst_396159FF)
			activated=true;
		break;
	case 1634:
		with (inst_396159FF)
			activated=false;
		break;
	
	//Final fall, this time we don't care about stopping it
	case 1652:
		with (inst_396159FF)
			activated=true;
		
		//There's some spikes below, make sure they're not activated
		with (obj_gauntlet_popoutspikes)
			if (y>464)		//Arbitrary
				activated=false;
		break;
	
	//Start ejecting the spikes to get player moving, then start the laser chase
	//We have one laser, every time we set one moving, we will create a new in it's place
	//Repeat, say 8 times because if the player is still alive by then, then I don't care, they can do what they want
	
	//Beat 70 is where we start spike ejects (check video for when we should start laser chase - give a two beat leeway)
	//First laser
	case 1704:
		newLaser=instance_create_layer(352,464,"objects",obj_office_laser);
		with (newLaser)	{
			maxspeed=0;
			xstart=room_width*2;
		}
		inst_627690B6.maxspeed=4;
		break;
}

//I'm going to do the spike ejecting thing (after platform drop) here because it's easier to automate it via a for loop
for (var i=0; i<15; i+=1)
	if (counter==1680+6*i)
		with (obj_gauntlet_popoutspikes)
			if (x==208+i*16)
				activated=true;

//This repeats laser creation forever
if (counter>1704 and counter%48==0)	{
	newLaser.maxspeed=4+instance_number(obj_office_laser)*0.2;
	newLaser=instance_create_layer(352,464,"objects",obj_office_laser);
		with (newLaser)	{
			maxspeed=0;
			xstart=room_width*2;
		}
}