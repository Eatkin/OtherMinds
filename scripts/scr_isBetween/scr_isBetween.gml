/// @function scr_isBetween(n,a,b);
/// @description check if n is between a and b
/// @param {real} n the value to check
/// @param {real} a first bound
/// @param {real} b second bound

var n=argument0;
var a=argument1;
var b=argument2;

return n==clamp(n,min(a,b),max(a,b));