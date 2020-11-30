//Created 06/10/19
//Last updated 06/10/19

if (holdingtimer=-1)
	{
		scr_set_vibration(1,1,10);
		scr_snap_to_floor();
		//Find the object
		//This may put it in other characters inventories IF I choose to in future, but it will break
		if (object_get_parent(object_index)==parent_main_character)
			var grid=global.inventory;
		else
			var grid=localinventory;
			
		var i;
		//Failsafe incase I'm an idiot
		var objname="can't find object, tell Ed he is an idiot";
		for (i=0;i<ds_grid_height(grid);i+=1)
			{
				if (ds_grid_get(grid,INVENTORY.ITEMID,i)==holding)
					{
						var objname=ds_grid_get(grid,INVENTORY.ITEMNAME,i);
						break;
					}
			}
		sprite_index=sprite_holding;
		//If we couldn't find the floor we have an alternative sprite
		var checkpos=(global.gravdirection==90)	?	bbox_bottom+1	:	bbox_top-1;
		if (!position_meeting(x,checkpos,obj_solid) and (!position_meeting(x,checkpos,obj_semisolid) or place_meeting(x,y,obj_semisolid)))
			sprite_index=sprite_holding_air;
		holdingtimer=30;
		scr_queue_dialogue_box(name+" "+scr_return_text(288)+objname+scr_return_text(294)+"!");
		
		//SPECIAL CASE - if you've collected all the key card shards, we add an additional dialogue box
		//Inventory check - the shard is now in our inventory from the inherited event
		var shard1=scr_inventory_check(obj_keycard_D_shard1);
		var shard2=scr_inventory_check(obj_keycard_D_shard2);
		var shard3=scr_inventory_check(obj_keycard_D_shard3);
		var shardsum=shard1+shard2+shard3;
		if (shardsum==3)
			{
				scr_inventory_remove(obj_keycard_D_shard1);
				scr_inventory_remove(obj_keycard_D_shard2);
				scr_inventory_remove(obj_keycard_D_shard3);
				scr_inventory_add(obj_key_card_D);
				scr_queue_dialogue_box(scr_return_text(559));
				with (global.currentinstance)
					{
						scr_todo_discover(14);
					}
			}
			
		//Another special case, power up scroll
		if (holding==obj_scrollIneffibleWisdom)
			{
				scr_queue_dialogue_box(scr_return_text(661));
				global.playerpowerlevel=2;
				parent_main_character.powerlevel=2;
			}
	}
	
if (holdingtimer==0 and ds_queue_empty(global.dialoguequeue))
	{
		if (sprite_index==sprite_holding_air)
			state=PlayerState.air;
		else
			state=PlayerState.idle;
			
		xspeed=0;
		yspeed=0;
		holdingtimer=-1;
		exit;
	}
	
holdingtimer=max(holdingtimer-1,0);

if (holdingtimer==15)
	scr_set_vibration(1,1,10);