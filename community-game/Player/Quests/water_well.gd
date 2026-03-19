extends MeshInstance3D


func _on_interactable_component__interaction_signal() -> void:
	Dialogic.VAR.DeliverWaterQuest.GotQuest = true
	Globals.PlayerReference.QuestManagerNode.try_increment_task(ProgressionTracker.TaskTags.Deliver_Water_Collect)
	print("GotWater")
