extends Node
class_name Quest

@export var ID: int
@export var Name: String
@export var Description: String

@export var Stages: Array[Checklist]

@export_group("Debug")
@export var State: States = States.Available

# Values to be laoded
enum States {Available, Active, Complete}
var Completed: bool = false
var CurrentStage: int = 0

var RelatedUI: QuestBox

func _ready() -> void:
	# TEMPORARY, MAKES THE FIRST STAGE ACTIVE
	begin_quest()


func begin_quest():
	update_active_checklist(0)

# Advances the quest stage
func advance_stage():
	# Checks if the quest is actively being done
	if State == States.Active:
		var MaxStageIndex: int
		MaxStageIndex = Stages.size() - 1
		
		# Checks if the quest should be completed altogether
		if not (CurrentStage >= MaxStageIndex):
			CurrentStage += 1
			update_active_checklist(CurrentStage)
		else:
			Completed = true


func update_active_checklist(index: int):
	Stages[index].IsActive = true
	RelatedUI.update_display()


func create_task_boxes():
	for x in Stages[CurrentStage].Tasks:
		pass
