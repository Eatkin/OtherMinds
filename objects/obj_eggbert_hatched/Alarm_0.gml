/// @description

var birdboi=instance_create_layer(608,16,layer,obj_birdboi);
birdboi.flyingtoeggbert=true;
var objtofollow=birdboi;
with (obj_camera)
	{
		if following=noone
			{
				following=objtofollow;
			}
	}