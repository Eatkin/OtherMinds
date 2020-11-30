/// @description

/*What do:
Decide what buttons to draw and find the max width
Create the buttons where they should be
Move buttons to x-room_width
Create the chevron too
*/
draw_set_font(global.font);			//If I don't do this it isn't alreayd set...for some reason? Which is very strange

//Set up arrays for the buttons
text[0]="FNEEEBELFE FNARF if you see this something went horribly wrong.";
orbsFound[0]=0;
secretsFound[0]=0;
youAreHere[0]=false;
	
//Now we loop through the todo to get all the text
var grid=global.roomarray;
var len=ds_grid_height(grid);

//Loop until we find a discovered room
//This fucking sucks shit
var count=0;
for (var i=0; i<len; i+=1)	{
	if (grid[# ROOMARRAY.DISCOVERED, i]>0)	{	
			//Now we have an innder loop that loops through every room in that room set
			var ref=grid[# ROOMARRAY.ROOMSET, i];		//The enum of the room set
			text[count]=scr_roomsetFindName(ref);
			
			//Actually I now need to count back to the starting position of the room set incase they're discovered out of order or something stupid idk
			var k=1;
			while (i-k>=0 and grid[# ROOMARRAY.ROOMSET, i-k]==ref)
				k+=1;
				
			k-=1;		//Adjust otherwise it over-shoots and gets stuck in an infinite 
			
			//Now the inner loop to fill in the other stuff
			for (var j=i-k; j<len; j+=1)	{
				//Break condition for when we pass all the rooms in this set
				if (grid[# ROOMARRAY.ROOMSET, j]!=ref)
					break;
					
				//Else we add stuff
				//Add the bitflip THEN bitflip the final results
				//Because if orbsFound=0, i.e. orbs have been found in every room, then we bit flip it
				//If we don't bitflip it orbsFound=some arbitrary number and so it's not as easy to sort
				//Uhh yeah
				//This is confusing
				orbsFound[count]+=(1-grid[# ROOMARRAY.ORBSFOUND, j]);
				secretsFound[count]+=(1-grid[# ROOMARRAY.SECRETSFOUND, j]);
				if (room==grid[# ROOMARRAY.ROOM, j])
					youAreHere[count]=true;
			}
			//Continue the loop from the next row
			i=j;
			count+=1;
			//I need to re-initialise these ready bceause I'm adding to them
			orbsFound[count]=0;
			secretsFound[count]=0;
			youAreHere[count]=0;
	}
}

//Find the widest text
var maxLength=0;
var len=array_length_1d(text);
for (var i=0; i<len; i+=1)
	maxLength=max(maxLength,string_width(text[i]));
	
var buttonPadding=6;							//Either side of the button
maxLength+=buttonPadding*2;

maxLength=16*ceil(maxLength/16);
var buttonhreps=(maxLength/16)-2;		//How many middle section repeats for the buttons

buttonSpacing=sprite_get_height(spr_menuButton)*1.5;		//We use this to offset y coordinates
																//I.e. area occupied is buttonSpacing*len-buttonSpacing/3;
																//BUT I want it slightly higher anyway so ignore the final buttonSpacing/3
																//Change to buttonSpacing*(len-1)
//var totalSpace=buttonSpacing*(len-1);			//Unneeded

//Set starting coordinates for buttons
//x is essentially starting at 0.4, but shifted one room width to the left so it starts off screen
xButtonTarget=480*0.1;			//480 being the view width
var xx=xButtonTarget+480;		//Off to the right
var yy=buttonSpacing;			//We start at the top because these might span multiple "pages"
button=0;
buttonSelected=0;

/*Side note: How many buttons can fit on screen?
Buttonspacing <---Blank space
Then each button takes up "buttonSpacing" amount of screen space
so it's floor(view_height/buttonSpacing)-1
*/

buttonsPerScreen=floor((270-global.helpbar*sprite_get_height(spr_HUD_box))/buttonSpacing)-2;
menuyOffset=0;		//The offset for where the menu draws	-	This should be an integer for how many "buttonSpacings" the menu is offset by

//Now loop thru and create some buttons
//if textNum==0 then the todo list is empty so it's a special case

for (i=0; i<len; i+=1)	{
	button[i]=instance_create_layer(xx,yy+buttonSpacing*i,layer,obj_areasButton);
	button[i].text=text[i];
	button[i].hrepeats=buttonhreps;
	if (i==buttonSelected)	{
		button[i].highlighted=true;
		button[i].x+=28;
		chevron=instance_create_layer(xx,yy+buttonSpacing*i,layer,obj_pauseMenuChevron);
		chevron.attachedTo=button[i];
	}
	
	//Here we add the supplementary details		
	//Make sure to bitflip orbsFound and secretsFound again 
	//If we HAVEN'T found all secrets or orbs, orbsFound=some arbitrary value so -sign means we can set it to a boolean
	//Oh god this might be the most jank code I've ever written so far
	//But it fucken works as long as I never have to edit it
	button[i].orbsFound=1-sign(orbsFound[i])
	button[i].secretsFound=1-sign(secretsFound[i]);
	button[i].youAreHere=youAreHere[i];
}

//Now we have created all the buttons we need a timer for easings
timer=0;
activated=false;

//Cooldown
vinputCooldownMax=20;
vinputCooldown=0;
vinputClicks=0;

//Create some arrows
arrow[0]=instance_create_layer(500,20,layer,obj_upIcon);
arrow[1]=instance_create_layer(500,270-20-global.helpbar*sprite_get_height(spr_HUD_box),layer,obj_downIcon);

if (len-1>buttonsPerScreen)
	arrow[1].alpha=1;			//Set target alpha to 1 if we can scroll down