extends Sprite3D



func _on_interactable_component__interaction_signal() -> void:
	Dialogic.start("test_timeline")
