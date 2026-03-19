extends Node
class_name CameraManager

var CurrentCamera: Camera3D
var CameraArray: Array[Camera3D]

func switch_camera():
	CurrentCamera = CameraArray[0]
	CurrentCamera.make_current()

func check_for_camera_switch():
	if CameraArray.size() != 0:
		if  CameraArray[0] != CurrentCamera:
			Globals.PlayerReference.switch_to_fixed_camera()
			switch_camera()
	else:
		CurrentCamera = null
		Globals.PlayerReference.switch_to_fp_camera()


func add_to_camera_array(camera: Camera3D):
	CameraArray.insert(0, camera)
	check_for_camera_switch()

func remove_from_camera_array(camera: Camera3D):
	CameraArray.erase(camera)
	check_for_camera_switch()
