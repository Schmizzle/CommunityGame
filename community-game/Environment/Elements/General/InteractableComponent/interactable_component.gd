extends StaticBody3D
class_name InteractableComponent

signal _interaction_signal


func on_interacted() -> void:
	_interaction_signal.emit()
	
