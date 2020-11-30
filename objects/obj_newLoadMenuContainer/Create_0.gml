/// @description

/*What do:
Decide what buttons to draw and find the max width
Create the buttons where they should be
Move buttons to x-room_width
Create the chevron too
*/

var buttonSpacing=64;		//Buttons are 48 px tall so leave 16 between them
var totalSpace=buttonSpacing*3;

//Set starting coordinates for buttons
//x is essentially starting at 0.4, but shifted one room width to the left so it starts off screen
xButtonTarget=room_width*0.3;
var xx=xButtonTarget+room_width;
var yy=(270-totalSpace)*0.5+270;		//Add 270 to move it one screen size down
button=0;
buttonSelected=0;

//Now loop thru and create some buttons		
for (i=0; i<3; i+=1)	{
	button[i]=instance_create_layer(xx,yy+buttonSpacing*i,layer,obj_newLoadGameButton);
	button[i].gameNum=i+1;
	/*ADD ICON, DATE AND PERCENTAGE HERE*/
	var fname="save"+string(i+1)+".OM";
	if (file_exists(fname))	{
		button[i].gameExists=true;
		//Find relvant info from the file
		var file=file_text_open_read(fname);
		//Skip warning and whatever info
		repeat(3)
			file_text_readln(file);
		var str=file_text_read_string(file);	//This is a list encoded as a string
		file_text_close(file);
		
		//Now start unpacking the list content
		var _list=ds_list_create();
		ds_list_read(_list,str);
		button[i].icon=asset_get_index(_list[| 0]);
		button[i].date=_list[| 1];
		button[i].percentage=string(_list[| 2])+"%";
		ds_list_destroy(_list);
	}
	
	if (i==buttonSelected)	{
		button[i].highlighted=true;
		button[i].x+=28;
		chevron=instance_create_layer(xx,yy+buttonSpacing*i,layer,obj_menuChevron);
		chevron.attachedTo=button[i];
	}
}

//Now we have created all the buttons we need a timer for easings
timer=0;
activated=false;

//Cooldown
vinputCooldownMax=20;
vinputCooldown=0;
vinputClicks=0;

//Text fade in n out
textAlpha=0;
headerText="This is a bug";