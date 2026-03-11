extends Resource
class_name Task

@export var Name: String
@export var Description: String
@export var Tag: String
@export var AmountNeeded: int = 1

@export var OwningChecklist: Checklist

# Values to be loaded
var Completed: bool
var Amount: int = 0

func _init() -> void:
	pass

# when requirement is completed
func increment():
	if (not Completed) and OwningChecklist.IsActive:
		Amount += 1
		Amount = clamp(Amount, 0, AmountNeeded)
		
		if Amount >= AmountNeeded:
			Completed = true
			OwningChecklist.increment_completed()
