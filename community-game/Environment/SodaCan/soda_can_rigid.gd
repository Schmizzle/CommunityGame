extends RigidBody3D

@export var Message: String = "Slurp"


func _on_interactable_component__interaction_signal() -> void:
	print(Message)
	queue_free()
