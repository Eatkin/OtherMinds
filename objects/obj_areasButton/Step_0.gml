/// @description

if (highlighted and myContainer==noone)	{
	myContainer=instance_create_layer(0,0,layer,obj_areasDescription);
	myContainer.orbsFound=sign(orbsFound);
	myContainer.secretsFound=sign(secretsFound);
	myContainer.youAreHere=youAreHere;
}
	
if (!highlighted and myContainer!=noone)	{
	myContainer.active=false;
	myContainer=noone;
}