extends StaticBody3D

@export var Message: String = "Vended!"


func _on_interactable_component__interaction_signal() -> void:
	print(Message)
