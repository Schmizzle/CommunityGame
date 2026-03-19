extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_interactable_component__interaction_signal() -> void:
	Dialogic.VAR.DeliverWaterQuest.GotQuest = true
	Globals.PlayerReference.QuestManagerNode.try_increment_task(ProgressionTracker.TaskTags.Deliver_Water_Collect)
	print("GotWater")
