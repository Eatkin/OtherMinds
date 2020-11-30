with (obj_block)
	{
		visible=true;
		sprite_index=spr_block_black;
	}
	
if scr_event_check_complete(global.edhouse_events,EVENTS_EDHOUSE.COLLECTEDTREASUREMAP)=true
	{
		instance_destroy(inst_32ED5CF4);
		with (inst_53BF2F13)
			{
				x=64;
				y=64;
			}
		with (inst_673E9AA2)
			{
				activated=false;
			}
		with (inst_48CF7516)
			{
				x=544;
				y=208;
			}
		with (inst_32C6F142)
			{
				x=608;
				y=64;
			}
		with (inst_563F508C)
			{
				activated=true;
			}
	}