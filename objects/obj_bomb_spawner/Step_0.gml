/// @description

if (global.hardpause)
	exit;
	
//Respawn a bomb if there isn't something there
if (!instance_exists(mybomb))
	{
		//do stuff
		if (respawntimer=-1)
			respawntimer=respawntimermax;
		respawntimer=max(0,respawntimer-1);
		if (respawntimer==0)
			{
				if (!place_meeting(x,y,parent_possessable))
					{
						mybomb=instance_create_layer(x,y,layer,obj_bomb_block);
						mybomb.whitesprite=true;
						mybombflashtimer=60;
						respawntimer=-1;
					}
			}
		exit;
	}

//Flash the bomb white
if (mybombflashtimer%10==0 and mybombflashtimer>=0)
	{
		mybomb.whitesprite=mybomb.whitesprite^1;
	}
if (mybombflashtimer>=0)
	{
		mybombflashtimer-=1;
	}