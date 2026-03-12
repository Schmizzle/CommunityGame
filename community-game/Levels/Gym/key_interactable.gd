extends StaticBody3D

@export var keyLock: String 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_interactable_component__interaction_signal() -> void:
	print("Pickup Key")
