extends Area3D
class_name CameraArea

@onready var cameras = get_tree().get_nodes_in_group("Camera Group")
@onready var myCam: Camera3D = $"../Camera3D"
@onready var camerasParent: Node3D = $"../.."
@export var followPlayer:bool = false
@export var offset: Vector3

func _on_body_entered(body: Node3D) -> void:
	if(!camerasParent.fixedCamMode):
		print(body.name)
		if body is Player:
			print("cam change")
			#for c in cameras:
			myCam.current = true	

func _process(delta: float) -> void:
	if followPlayer:
		var newPos = Globals.PlayerReference.global_position + offset
		myCam.global_position.z = newPos.z
		
		
