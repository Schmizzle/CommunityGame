extends Sprite3D

@export var timelineToRun: String
@export var myName: String

func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _on_interactable_component__interaction_signal() -> void:
	Dialogic.VAR.Speaker = myName
	Dialogic.start(timelineToRun)

func _on_dialogic_signal(arg: String):
	if arg == "leave":
		if Dialogic.VAR.Speaker == myName:
			queue_free()
