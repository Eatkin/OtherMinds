//Created 24/11/19
//Last updated 24/11/19

switch (global.language)
	{
		case LANGUAGE.ENGLISH:	
			{
				scr_load_text();
				break;
			}
		case LANGUAGE.GERMAN:
			{
				scr_load_text_de();
				break;
			}
		default:
			{
				scr_load_text();
				break;
			}
	}