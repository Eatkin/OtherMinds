//Okay I didn't write this script that's why it seems to not know the existence of switch statements

///string_keycheck(key);

//Checks the given key and returns it as a string. Also detects vk_constants.

// vk_constants
//Left
if argument0 = (vk_left)
{
    return scr_return_text(73);
}

//Right
if argument0 = (vk_right)
{
    return scr_return_text(74);
}

//Up
if argument0 = (vk_up)
{
    return scr_return_text(75);
}

//Down
if argument0 = (vk_down)
{
    return scr_return_text(76);
}

//Enter
if argument0 = (vk_enter)
{
    return scr_return_text(77);
}

//Escape
if argument0 = (vk_escape)
{
    return scr_return_text(78);
}

//Space
if argument0 = (vk_space)
{
    return scr_return_text(79);
}

//Shift
if argument0 = (vk_shift)
{
    return scr_return_text(80);
}

//Control
if argument0 = (vk_control)
{
    return scr_return_text(81);
}

//Alt
if argument0 = (vk_alt)
{
    return scr_return_text(82);
}

//Backspace
if argument0 = (vk_backspace)
{
    return scr_return_text(83);
}

//Tab
if argument0 = (vk_tab)
{
    return scr_return_text(84);
}

//Home
if argument0 = (vk_home)
{
    return scr_return_text(85);
}

//End
if argument0 = (vk_end)
{
    return scr_return_text(86);
}

//Delete
if argument0 = (vk_delete)
{
    return scr_return_text(87);
}

//Insert
if argument0 = (vk_insert)
{
    return scr_return_text(88);
}

//Page Up
if argument0 = (vk_pageup)
{
    return scr_return_text(89);
}

//Page Down
if argument0 = (vk_pagedown)
{
    return scr_return_text(90);
}

//Pause
if argument0 = (vk_pause)
{
    return scr_return_text(91);
}

//Printscreen
if argument0 = (vk_printscreen)
{
    return scr_return_text(92);
}

//F1
if argument0 = (vk_f1)
{
    return scr_return_text(93);
}

//F2
if argument0 = (vk_f2)
{
    return scr_return_text(94);
}

//F3
if argument0 = (vk_f3)
{
    return scr_return_text(95);
}

//F4
if argument0 = (vk_f4)
{
    return scr_return_text(96);
}

//F5
if argument0 = (vk_f5)
{
    return scr_return_text(97);
}

//F6
if argument0 = (vk_f6)
{
    return scr_return_text(98);
}

//F7
if argument0 = (vk_f7)
{
    return scr_return_text(99);
}

//F8
if argument0 = (vk_f8)
{
    return scr_return_text(100);
}

//F9
if argument0 = (vk_f9)
{
    return scr_return_text(101);
}

//F10
if argument0 = (vk_f10)
{
    return scr_return_text(102);
}

//F11
if argument0 = (vk_f11)
{
    return scr_return_text(103);
}

//F12
if argument0 = (vk_f12)
{
    return scr_return_text(104);
}

//Numpad 0
if argument0 = (vk_numpad0)
{
    return scr_return_text(105);
}

//Numpad 1
if argument0 = (vk_numpad1)
{
    return scr_return_text(106);
}

//Numpad 2
if argument0 = (vk_numpad2)
{
    return scr_return_text(107);
}

//Numpad 3
if argument0 = (vk_numpad3)
{
    return scr_return_text(108);
}

//Numpad 4
if argument0 = (vk_numpad4)
{
    return scr_return_text(109);
}

//Numpad 5
if argument0 = (vk_numpad5)
{
    return scr_return_text(110);
}

//Numpad 6
if argument0 = (vk_numpad6)
{
    return scr_return_text(111);
}

//Numpad 7
if argument0 = (vk_numpad7)
{
    return scr_return_text(112);
}

//Numpad 8
if argument0 = (vk_numpad8)
{
    return scr_return_text(113);
}

//Numpad 9
if argument0 = (vk_numpad9)
{
    return scr_return_text(114);
}

//Multiply
if argument0 = (vk_multiply)
{
    return scr_return_text(115);
}

//Divide
if argument0 = (vk_divide)
{
    return scr_return_text(116);
}

//Add
if argument0 = (vk_add)
{
    return scr_return_text(117);
}

//Subtract
if argument0 = (vk_subtract)
{
    return scr_return_text(118);
}

//Decimal
if argument0 = (vk_decimal)
{
    return scr_return_text(119);
}

// Printable characters
if (argument0==clamp(argument0,65,90))
	{
		return chr(argument0+32);
	}
//This should never trigger but I'll leave it incase
return string_lower(chr(argument0));