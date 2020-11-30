/// @description

if (highlighted and myContainer==noone)	{
	myContainer=instance_create_layer(0,0,layer,obj_inventoryDescription);
	myContainer.text=description;
	myContainer.sprite=sprite;
	if (!descriptionHeightCalculated)	{
		descriptionHeightCalculated=true;
		var sep=string_height("A");
		var maxWidth=116;		//Pre-calculated
		descriptionHeight=string_height_ext(description,sep,maxWidth);
	}
	
	if (sprite==-1)
		myContainer.vrepeats=max(2,ceil((12+descriptionHeight)/16));
	else
		myContainer.vrepeats=max(3,ceil((descriptionHeight)/16)+2);			//extra vrepeats account for paddings + sprite
}
	
if (!highlighted and myContainer!=noone)	{
	myContainer.active=false;
	myContainer=noone;
}