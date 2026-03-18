extends Node3D
class_name NPCTalkingComponent

@export var NPCParent: NPC
@export var InteractComponent: InteractableComponent


var BeingTalkedTo: bool = false


func _ready() -> void:
	InteractComponent._interaction_signal.connect(on_interacted_with)


func on_interacted_with() -> void:
	start_talking()


func start_talking():
	Globals.PlayerReference.change_input_enabled(false, false, Input.MOUSE_MODE_VISIBLE)
	BeingTalkedTo = true
	Dialogic.start(NPCParent._get_timeline_to_say())
	Dialogic.timeline_ended.connect(stop_talking)


func stop_talking():
	Globals.PlayerReference.change_input_enabled(true, true, Input.MOUSE_MODE_CAPTURED)
	BeingTalkedTo = false
	Dialogic.timeline_ended.disconnect(stop_talking)
