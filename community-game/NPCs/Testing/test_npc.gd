extends NPC

@export var DefaultTimelineToSay: DialogicTimeline
@export var DifferentTimeline: DialogicTimeline


func get_timeline_to_say() -> DialogicTimeline:
	if ProgressionTracker.TestBool:
		return DifferentTimeline
	else:
		return DefaultTimelineToSay
