//Created: 14/06/19
//Last updated: 12/09/19

//Basically just set up a global ds grid at game start to hold all the buttons and what they do
//All objects will read and write from this so I can display it at the bottom of the screen

global.tipsgrid=ds_grid_create(6,2);
hudheight=sprite_get_height(spr_HUD_box);
maxwidth=sprite_get_width(spr_HUD_box);
maxwidth=480;

scr_HUD_tips_clear();

//Top value will be the input reference which will probably be unused other than for me to look it up
//Bottom value will be a string or a 0
//Each instance will write to the ds_grid depending on state
//Then this object will display the values at the bottom of the screen like The Moonstone Equation
//Anyway I'll make a script for this

/*TOTALLY IMPORTANT COMMENT WHICH I'LL PROBABLY NEVER SEE AGAIN
IF I SET UP KEY REBINDING IT NEEDS TO MODIFY THE KEYS PARSED TO THE TIPS ARRAY*/

//Actually i fixed that

//Why is this 6/7th comments?
//Anyway surfaces
HUD_surf=surface_create(maxwidth*2,hudheight);
surf_x=0;
marquee=false;