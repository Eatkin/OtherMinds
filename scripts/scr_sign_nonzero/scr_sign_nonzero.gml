//Created 31/07/19
//Last updated 31/07/19

//This is a modified sign() function that returns 1 instead of 0
//x<0 returns -1
//x=0 returns 1
//x>0 returns 1

var _x=argument0;
_x=sign(_x);
_x+=abs(_x)^1;
return _x;