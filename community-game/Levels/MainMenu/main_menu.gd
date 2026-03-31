extends Node3D

@export var LevelToPlay: PackedScene

@export var PlayButton: Button
@export var QuitButton: Button

func _ready() -> void:
	PlayButton.pressed.connect(start_game)
	QuitButton.pressed.connect(quit_game)

func start_game():
	var GameManagerRef: GameManager = get_tree().get_first_node_in_group("GameManager")
	
	GameManagerRef.load_new_level(LevelToPlay)


func quit_game():
	get_tree().quit()
