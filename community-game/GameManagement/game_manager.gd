extends Node
class_name GameManager

@export var QuestManagerNode: QuestManager
@export var CameraManagerNode: CameraManager
@export var LevelParent: Node

@export var StartUpLevel: PackedScene
var CurrentLevel: Node3D


func _ready() -> void:
	load_new_level(StartUpLevel)


func load_new_level(newLevel: PackedScene):
	if CurrentLevel != null:
		CurrentLevel.queue_free()
	
	var LevelInstance = newLevel.instantiate()
	LevelParent.add_child(LevelInstance)
	
	CurrentLevel = LevelInstance
