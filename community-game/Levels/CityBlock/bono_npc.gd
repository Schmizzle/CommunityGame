extends NPC

@export var Timeline1: DialogicTimeline



func _get_timeline_to_say() -> DialogicTimeline:
	return Timeline1

func _on_day_night_manager_new_day() -> void:
	print("Bono Hears its a new day!")
	Dialogic.VAR.EscapeQuest.escapeDidToday = false
	Dialogic.VAR.LumberJack.lumberGavePlankToday = false
