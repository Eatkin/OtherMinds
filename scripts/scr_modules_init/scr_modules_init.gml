//Created 05/10/19
//Last updated 05/10/19

//This will set up all the modules as false so I don't get any uninitialised variable errors
//Then in the create code I can pick which modules I want

//Common modules
runenabled=false;
jumpenabled=false;
gravityenabled=false;
canbehurtenabled=false; //Can the character be hurt
canhurtenabled=false; //Can the character hurt you
enemiesattackenabled=false; //Enemies hurt you when they touch you if this is enabled
smoothaccelerationenabled=false;
talkenabled=false;
usesageenabled=true;

//Less common
waitinganimationenabled=false;
waitingtimeoutenabled=false;
blinkingenabled=false;
pushingenabled=false;
pullingenabled=false;
lookupenabled=false;
duckenabled=false;
ledgegrabenabled=false;
ledgeclimbenabled=false;
cliffedgeenabled=false;
springsenabled=false;
dustenabled=false;
jumpattackenabled=false; //Can you jump on enemies and hurt them
ledgeholdawayenabled=false;
walljumpenabled=false; //Wall jumping
wallclimbenabled=false; //Wall climbing

//Not common
teleportenabled=false;
freeflyingenabled=false; //For Sage and Sage-like characters
offscreenmarkerenabled=false;
airspriteflipenabled=false; //This flips the yscale of sprites in the air depending on movement direction
xscaleflipenabled=true; //This is true because it's almost always true and I don't want to go back and rewrite it all
decelerationenabled=true;
shoesenabled=false; //Shoes animation for falling off a cliff
respawnenabled=true;
jumponedenabled=false;
airmaskenabled=false;
wallmaskenabled=false;
dashenabled=false;
staticidleanimationenabled=false;
birdmodeenabled=false;
impactsoundenabled=false; //Play sound when entering idle state
digenabled=false;
shootingenabled=false;
interactwithsemisolidsenabled=true;

//Specific to approximately one character
collectitemsenabled=false;
slideoffcliffenabled=false;
splatenabled=false;
foottapenabled=false;
spinningenabled=false;
isasignenabled=false;
possessingenabled=false;
manualscalingenabled=false; //For manually setting x and y scale
explodeenabled=false; //Gives and explode button
explodeonwallsenabled=false;
fallwhendefeatedenabled=false; //Alternative for defeated where it will continue with its momentum but enable gravity
interactwithblocksenabled=true;
moveenabled=true; //Only used in free flying
reversewhendefeatedenabled=false; //For the pink bullets, their direction reverse when defeated
pausemenuoutline=false; //Outline the sprite on the pause menu - for black characters
moveoffscreenenabled=false;
imagespeedequalsdirenabled=false; //If we're moving left, image_speed is negative
smasherenabled=false; //Are we a smasher - this is for spawning Sage to the side of the object
gravityFlipEnabled=false;

harmful[0]=noone; //Initialise the array of harmful objects
interactable[0]=noone; //Initialise the array of interactable objects - I'm going to change interactions to this method