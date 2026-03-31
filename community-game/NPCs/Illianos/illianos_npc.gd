extends NPC

@export var Timeline1: DialogicTimeline

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _get_timeline_to_say() -> DialogicTimeline:
	return Timeline1
	
