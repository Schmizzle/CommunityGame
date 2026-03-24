extends NPC

@onready var DifferentTimeline = $"..".DifferentTimeline
@onready var DefaultTimelineToSay = $"..".DefaultTimelineToSay
@export var OutsideLocation: Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.current_animation = "Rig|Shrimping"
	$AnimationPlayer.play();
	Dialogic.signal_event.connect(moveOutside)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var questcomplete = Globals.PlayerReference.QuestManagerNode.try_increment_task(ProgressionTracker.TaskTags.Test_SodaDrink)
	if questcomplete:
		$AnimationPlayer.current_animation = "Rig|LegsOverTable"
		$AnimationPlayer.play();

func _get_timeline_to_say() -> DialogicTimeline:
	if ProgressionTracker.TestBool:
		return DifferentTimeline
	else:
		return DefaultTimelineToSay

func moveOutside(arg: String) -> void:
	if arg == "moveOutside":
		get_parent().position = OutsideLocation
