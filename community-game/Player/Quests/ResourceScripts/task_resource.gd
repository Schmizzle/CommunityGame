extends Resource
class_name Task

@export var Tag: ProgressionTracker.TaskTags
@export var Description: String
@export var Amount: int = 0
@export var AmountNeeded: int = 1

var Completed: bool = false
