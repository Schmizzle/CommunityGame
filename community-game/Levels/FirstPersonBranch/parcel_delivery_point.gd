extends Node3D

#make the task listed completed
@export var parcelToDeliver: ProgressionTracker.TaskTags


func _on_interactable_component__interaction_signal() -> void:
	Globals.PlayerReference.QuestManagerNode.try_increment_task(parcelToDeliver)
	
