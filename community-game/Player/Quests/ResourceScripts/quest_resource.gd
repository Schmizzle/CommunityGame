extends Resource
class_name Quest

@export var Tag: ProgressionTracker.QuestTags
@export var Name: String = "DEFAULT"
@export var Description: String = "DEFAULT"

enum QuestStates {Unavaible, Available, Active, Complete}
@export var State: QuestStates = QuestStates.Available

@export var TaskLists: Array[TaskList]
var ActiveTaskList: TaskList
