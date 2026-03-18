@abstract
@icon("res://NPCs/Base/NPCIcon.png")
extends Node3D
class_name NPC

@export var TalkingComponent: NPCTalkingComponent


@abstract
func _get_timeline_to_say() -> DialogicTimeline
