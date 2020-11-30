/// @description descriptions are stupid
// You can write your code in this editor

/*
THINGS TO REMEMBER:
COOLDOWN for MOVING BOTH H INPUT AND VINPUT
CURSOR movement - we can just set a relative cursor position
*/

//First criteria for if we can move
var cam=view_camera[0];
var camx=camera_get_view_x(cam);
var camy=camera_get_view_y(cam);
var camw=camera_get_view_width(cam);

//Ternery operators cause I am so smart
//Set whether cam is in the correct position
var camInPosition=(camx==menuTab*camw) ? true : false;
//Set whether we can move based on whether cam is in the correct position
var transitionExists=instance_exists(obj_transition);
canMove=(!transitionExists and camInPosition) ? true : false;

if (transitioningOut==true)
	{
		if (myTransition.transitioncomplete==true)
			{
				room_goto(rm_main_menu);
				exit;
			}
	}

moveCooldown=max(0,moveCooldown-1);

if (camInPosition==false)
	{
		camx=lerp(camx,menuTab*camw,0.2);
		if (abs(camx-menuTab*camw)<1)
			{
				camx=menuTab*camw;
			}
		camera_set_view_pos(cam,camx,camy);
	}
	
if (canMove==true)
	{
		//GATHER INPUTS
		var hinput=global.inputs[0];
		hinput=sign(hinput);
		var vinput=global.inputs[1];
		vinput=-sign(vinput);
		var selectInput=max(global.inputs[4],global.inputs[14]);
		var backInput=global.inputs[5];
		
		if (vinput==0 and hinput==0)
			moveCooldown=min(moveCooldown,5);
			

		if (vinput!=0 and moveCooldown==0)
			{
				moveCooldown=moveCooldownMax;
				selection[menuTab]+=vinput;
				var _select=selection[menuTab];
				selection[menuTab]=clamp(selection[menuTab],0,maxSelection[menuTab]);
				var soundToPlay;
				if (_select=selection[menuTab])
					soundToPlay=snd_menu_move; //Menu move
				else
					soundToPlay=snd_menu_no; //Menu nope
		
				audio_play_sound(soundToPlay,0,false);
				//No need to adjust volume here because this screen only appears for first time players
			}
		
		if (backInput==true)
			{
				var soundToPlay;
				if (menuTab==1)
					{
						soundToPlay=snd_menu_cancel;
						menuTab=0;
					}
				else
					{
						soundToPlay=snd_menu_no;
					}
				audio_play_sound(soundToPlay,0,false);
			}
			
		//Select input
		if (selectInput==true)
			{
				if (menuTab==0)
					{
						menuTab=1;
					}
				else
					{
						myTransition=scr_create_transition(0,TRANSITION.FADE_IN);
						transitioningOut=true;
						//Set difficulty
						global.difficulty=selection[1];
					}
				
				audio_play_sound(snd_menu_confirm,0,false);
			}
			
		//Now finally we deal with moving left and right (applicable for selecting gamepad type)
		if (hinput!=0 and moveCooldown==0)
			{
				moveCooldown=moveCooldownMax;
				if (menuTab==0 and selection[0]=0)
					{
						global.gamepadtype+=hinput;
						var type=global.gamepadtype;
						global.gamepadtype=clamp(global.gamepadtype,PAD.XBOX,PAD.NINTENDO);
						var soundToPlay;
						if (type==global.gamepadtype)
							{
								soundToPlay=snd_menu_slider;
							}
						else
							{
								soundToPlay=snd_menu_no;
							}
						audio_play_sound(soundToPlay,0,false);
					}
			}
	}
	
//lerp the cursors into position
//Y positions first cause they easy
cursor[0,1]=lerp(cursor[0,1],v_spacing*selection[0]*2,0.2);
cursor[1,1]=lerp(cursor[1,1],v_spacing*selection[1],0.2);
//Now x
cursor[0,0]=lerp(cursor[0,0],-string_width(menuText[selection[0],0])*0.5-v_spacing*0.5,0.2);
cursor[1,0]=lerp(cursor[1,0],-string_width(menuText[selection[1],1])*0.5-v_spacing*0.5,0.2);

//HUD
//279 select, 280 back
scr_HUD_set_tips_buttons(global.kb_b_one);
scr_HUD_set_tips_text(scr_return_text(279));
if (menuTab==1)
	{
		scr_HUD_add_tips_buttons(global.kb_b_two);
		scr_HUD_add_tips_text(scr_return_text(280));
	}
	
//Show notifications
if (!instance_exists(obj_transition))
	{
		if (menuTab==1 and notificationShown==false)
			{
				scr_queue_notification(scr_return_text(581),NOTIFICATION.HINT);
				notificationShown=true;
			}
	}