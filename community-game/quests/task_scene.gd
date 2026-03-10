extends Node
class_name Task

@export var Name: String
@export var Description: String
@export var Tag: String
@export var AmountNeeded: int = 1

var OwningChecklist: Checklist

# Values to be loaded
var Completed: bool
var Amount: int = 0

# when requirement is completed
func increment():
	OwningChecklist = owner
	
	if (not Completed) and OwningChecklist.IsActive:
		Amount += 1
		Amount = clamp(Amount, 0, AmountNeeded)
		
		if Amount >= AmountNeeded:
			Completed = true
			OwningChecklist.increment_completed()
	
	
