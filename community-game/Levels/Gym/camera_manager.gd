extends Node3D

@export var fixedCamMode: bool = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if fixedCamMode:
		pass
	else:
		for c in get_tree().get_nodes_in_group("Camera Group"):
			var thisCam = c.get_child(0)
			if thisCam is Camera3D:
				thisCam.current = false
				print("disable camera")
		
