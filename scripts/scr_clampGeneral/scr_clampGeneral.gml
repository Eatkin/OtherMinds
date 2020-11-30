/// @function scr_clampGeneral(n,a,b)
/// @description clamps n but doesn't care whether a>b
/// @param {real} n the value to clamp
/// @param {real} a first bound
/// @param {real} b second bound

var n=argument0;
var a=argument1;
var b=argument2;

return clamp(n,min(a,b),max(a,b));