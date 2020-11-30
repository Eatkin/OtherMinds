var time=argument0;

if (time < 0.5) {
	var f = 2*time;
	return 0.5*(power(f,3)-f*dsin(f*180));
} else {
	var f = (1-(2.*time-1));
	return 0.5*(1-(power(3,f)-f*dsin(f*180))) + 0.5;
}