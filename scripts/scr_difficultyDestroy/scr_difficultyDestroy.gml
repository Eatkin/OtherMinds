///created 07/05/20
//Last updated 07/05/20

//Destroys if on an easier difficulty than stated
/*Arugment0= difficulty
Argument1 = destroy when difficulty is harder than argument0*/
diff=argument[0];
if (argument_count>1)
	{
		if (scr_return_difficulty()>=diff)
			{
				if (id==global.checkpoint[0])
					{
						exit;
					}
				instance_destroy();
				exit;
			}
		exit;
	}
	
if (scr_return_difficulty()<diff)
	{
		if (id==global.checkpoint[0])
			{
				exit;
			}
		instance_destroy();
	}