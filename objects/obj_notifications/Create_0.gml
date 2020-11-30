/// @description Insert description here
// You can write your code in this editor

showingnotification=0;
guiwidth=display_get_gui_width();
//These are for notifications on the RHS
//xbegin=guiwidth*1.1;
//xpos=xbegin;
//xtarget=guiwidth-sprite_get_width(spr_notification_oneline)-16;
//Left handed notifications:
xbegin=-224;
xpos=xbegin;
xtarget=16;
ypos=16;

minWidth=112;
hrepeats=minWidth/16;
vrepeats=2;

hpadding=7;
vpadding=6;