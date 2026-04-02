extends Node3D
class_name ParcelDeliveryPoint

#make the task listed completed
@export var parcelToDeliver: ProgressionTracker.TaskTags
@export var myBillboard: Sprite3D
var Deliverable = false


func set_deliverable(val: bool) -> void:
	Deliverable = val
	if val:
		myBillboard.visible = true
	else:
		myBillboard.visible = false


func _on_interactable_component__interaction_signal() -> void:
	if Deliverable:
		Globals.PlayerReference.QuestManagerNode.try_increment_task(parcelToDeliver)
		if Globals.PlayerReference.QuestManagerNode.query_task_complete(parcelToDeliver):
			set_deliverable(false)
