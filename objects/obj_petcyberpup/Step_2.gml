/// @description pass the outline shader to Mig

owner.outlineshader=max(outlineshader,owner.outlineshader);

if (ds_queue_empty(global.dialoguequeue)==false)
	{
		owner.outlineshader=false;
	}