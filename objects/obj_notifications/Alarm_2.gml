/// @description Lerping out then dequeue the notification
// You can write your code in this editor

showingnotification=false;
ds_queue_dequeue(global.notificationqueue);

xbegin=-2*hrepeats*16;		//Update xbegin