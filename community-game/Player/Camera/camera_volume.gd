extends Area3D
class_name CameraVolume


@export var Camera: Camera3D


func _on_body_entered(body: Node3D) -> void:
	Globals.PlayerReference.CameraManagerNode.add_to_camera_array(Camera)
	print("New camera volume entered")


func _on_body_exited(body: Node3D) -> void:
	Globals.PlayerReference.CameraManagerNode.remove_from_camera_array(Camera)
	print("Camera volume exited")
