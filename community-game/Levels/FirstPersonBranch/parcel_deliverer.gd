extends Node3D

@export var allDeliveryPoints: Array[ParcelDeliveryPoint]
@export var DeliveryQuest: ProgressionTracker.QuestTags

func _on_interactable_component__interaction_signal() -> void:
	Globals.PlayerReference.QuestManagerNode.activate_quest(ProgressionTracker.QuestTags.Postman)
	var myQuest = Globals.PlayerReference.QuestManagerNode.get_quest_of_tag(DeliveryQuest)
	print("all quests length: "+ str(Globals.PlayerReference.QuestManagerNode.Quests.size()) ) # gives 4
	print("intended quest" + str(DeliveryQuest))	#gives 5
	
	
	# activate all parcelboxes that have the same task tags as in current quest. Very cool that this works!
	for i in  myQuest.ActiveTaskList.Tasks:
		for j in allDeliveryPoints:
			print("Parcel:" + str(j.parcelToDeliver))
			print("TaskTag:" + str(i.Tag))
			if j.parcelToDeliver == i.Tag:
				j.set_deliverable(true)
				print("Deliveryed")

	#hopefull prevent double activating quests
	queue_free()
	
