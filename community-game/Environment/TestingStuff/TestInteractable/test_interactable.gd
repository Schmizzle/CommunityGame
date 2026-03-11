extends StaticBody3D

@export var Message: String = "N/A"
@export var QuestTag: String


func _on_interactable_component__interaction_signal() -> void:
	print(Message)
	
	Globals.PlayerReference.QuestManage.try_increment_task(QuestTag)
