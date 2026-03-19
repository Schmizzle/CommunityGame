extends StaticBody3D

@export var Message: String = "Vended!"
@export var sodaCan: PackedScene

func _on_interactable_component__interaction_signal() -> void:
	print(Message)
  	# Creates a new instance of the _spawn_scene
	var spawn = preload("res://Environment/TestingStuff/VendingMachine/SodaCan/soda_can.tscn").instantiate() 

	$SpawnLoc.add_child(spawn)
	$SpawnLoc.global_position = spawn.global_position
