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
position=floor(counter/30);

if (counter>0 and counter==counter+counter%30 and audio_is_playing(theMusic))
	with (parent_main_character)
		instance_create_layer(x,y,layer,obj_quaver);

//Stuff
switch (counter)	{
	case 636:
		//Fall from 96->336 i.e. 240 px
		//acceleration is 0.5px/frame
		//Max speed 10
		//So 20*21*0.25 is how far it goes until reaching terminal velocity (in 20 frames) i.e. 105
		//Then it takes another 14 frames to hit, so 24 frames before timer 660
		instance_activate_object(inst_66B2EB6F);
		instance_activate_object(inst_6EA2C56D);
		instance_activate_object(inst_4C16BB78);
		break;
	case 720:
		inst_74E80BB1.activated=true;
		break;
	//Cannons
	case 735:
		inst_6263D473.activated=true;
		break;
	case 736:
		inst_6263D473.activated=false;
		break;
	case 742:
		inst_43975910.activated=true;
		break;
	case 743:
		inst_43975910.activated=false;
		break;
	case 750:
		inst_4D79CDCD.activated=true;
		break;
	case 751:
		inst_4D79CDCD.activated=false;
		break;
	case 757:
		inst_43E79F4B.activated=true;
		break;
	case 758:
		inst_43E79F4B.activated=false;
		break;
	case 765:
		inst_5BAC9C1C.activated=true;
		break;
	case 766:
		inst_5BAC9C1C.activated=false;
		break;
	case 772:
		inst_3A334C6C.activated=true;
		break;
	case 773:
		inst_3A334C6C.activated=false;
		break;
	case 780:
		inst_6440EBB.activated=true;
		break;
	case 781:
		inst_6440EBB.activated=false;
		break;
	case 787:
		inst_78F8E226.activated=true;
		break;
	case 788:
		inst_78F8E226.activated=false;
		break;
	case 1420:
		inst_527ABF8D.activated=true;
		with (obj_gauntlet_popoutspikes)
			activated=true;
		break;
	case 1480:
		inst_42B3C80F.activated=true;
		break;
	case 1525:
		inst_97CFD1B.activated=true;
		break;
	case 1570:
		inst_78C2A7C.activated=true;
		break;
	case 1615:
		inst_15C5FDD7.activated=true;
		break;
	case 1660:
		inst_4FCA0F92.activated=true;
		break;
	case 1715:
		inst_5E6A2C72.activated=true;
		break;
	case 1760:
		inst_757281F2.activated=true;
		break;
	case 1860:
		with (obj_cannon)
			if (x>1999 and y>799)
				activated=true;
		break;
		
}