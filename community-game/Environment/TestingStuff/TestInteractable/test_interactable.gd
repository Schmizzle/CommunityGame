extends StaticBody3D

@export var Message: String = "N/A"


func _on_interactable_component__interaction_signal() -> void:
	print(Message)
