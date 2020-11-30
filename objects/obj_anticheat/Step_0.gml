/// @description

var player=parent_main_character;
if (place_meeting(x,y,player) and player.yprevious>player.y and player.xprevious>bbox_right)
	{
		if (player.state==PlayerState.idle or player.state==PlayerState.running or player.state==PlayerState.air)
			{
				var block=instance_create_layer(448,-32,layer,parent_push);

				//If there is block in the way, destroy new block and terminate script
				var destroyed=false;
				with (block)
					if (place_meeting(x,y,parent_push))	{
						instance_destroy();
						destroyed=true;
					}
				if (destroyed)
					exit;
					
					
				block.sprite_index=spr_overworldpushblock;
				with (obj_anticheatblocktracker)
					{
						ds_list_add(blocklist,block);
					}
				//Spawn a new one
				instance_create_layer(x,y,layer,object_index);
				instance_destroy();
			}
	}