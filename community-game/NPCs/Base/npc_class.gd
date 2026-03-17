@abstract
extends Node3D
class_name NPC

@export var TalkingComponent: NPCTalkingComponent


@abstract
func get_timeline_to_say() -> DialogicTimeline
