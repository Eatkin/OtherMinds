/// @description

if (highlighted and myContainer==noone)	{
	myContainer=instance_create_layer(0,0,layer,obj_todoDescription);
	myContainer.text=description;
	if (!descriptionHeightCalculated)	{
		descriptionHeightCalculated=true;
		var sep=string_height("A");
		var maxWidth=116;		//Pre-calculated
		descriptionHeight=string_height_ext(description,sep,maxWidth);
	}
	myContainer.vrepeats=max(2,ceil((12+descriptionHeight)/16));			//+12 to account for padding
}
	
if (!highlighted and myContainer!=noone)	{
	myContainer.active=false;
	myContainer=noone;
}