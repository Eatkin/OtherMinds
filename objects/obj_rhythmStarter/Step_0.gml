/// @description

var player=parent_main_character;

if (player.x!=player.xprevious or player.y!=player.yprevious)
	{
		if (rhythmBlocks)
			{
				var blocks=instance_create_layer(x,y,layer,obj_onOffRhythmSwitch);
				blocks.linkedInstance=obj_on_off_block_controller;
			}
		instance_create_layer(x,y,layer,instanceToCreate);
		instance_destroy();
	}