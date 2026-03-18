extends Resource
class_name TaskList

@export var Tag: ProgressionTracker.TasklistTags
@export var Description: String = "DEFAULT"
@export var Tasks: Array[Task]

var Completed: bool
