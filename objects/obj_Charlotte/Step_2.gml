/// @description get smushed by blocks

if state=PlayerState.ledgeclimb or state=PlayerState.debug or state=PlayerState.dead
	{
		exit;
	}

event_inherited();