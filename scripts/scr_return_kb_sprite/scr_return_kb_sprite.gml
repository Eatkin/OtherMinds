//Created 26th June 2019
//Last updated 26th June 2019

//This is based on the string keycheck script I didn't write
//I would've used a switch statement because I'm not retarded
//Anyway I want to "cleanse" the input allowed to be bound
//So hopefully numpads and f keys will be irrelevant
//Because why the fuck would someone want to bind them

var sprite=-1;

//Checks the given key and returns it as a string. Also detects vk_constants.

// vk_constants
//Left
if argument0 = (vk_left)
{
    sprite=spr_keyboardkeyleft;
}

//Right
if argument0 = (vk_right)
{
    sprite=spr_keyboardkeyright;
}

//Up
if argument0 = (vk_up)
{
	sprite=spr_keyboardkeyup;
}

//Down
if argument0 = (vk_down)
{
    sprite=spr_keyboardkeydown;
}

//Enter
if argument0 = (vk_enter)
{
    sprite=spr_keyboardkeyenter;
}

//Space
if argument0 = (vk_space)
{
    sprite=spr_keyboardkeyspace;
}

//Backspace
if argument0 = (vk_backspace)
{
    sprite=spr_keyboardkeybackspace;
}

// Printable characters etc
//This is important because I directly draw the printable characters to the keyboard thing
return sprite;