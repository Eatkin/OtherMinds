//created 07/05/20
//Last update 07/05/20

//I use this to return difficulty so I have more control

if (global.attract==true or instance_exists(obj_timetrial))
	return DIFFICULTY.NORMAL;

return global.difficulty;