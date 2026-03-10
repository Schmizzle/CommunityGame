extends Node
class_name Quest

@export var TaskArray: Array[Task]

@export var ID: int
@export var Name: String
@export var Description: String

@export_group("Children")
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
	Stages[0].IsActive = true
	
	


# Advances the quest stage
func advance_stage():
	# Checks if the quest is actively being done
	if State == States.Active:
		var MaxStageIndex: int
		MaxStageIndex = Stages.size() - 1
		
		# Checks if the quest should be completed altogether
		if not (CurrentStage >= MaxStageIndex):
			CurrentStage += 1
		else:
			Completed = true
