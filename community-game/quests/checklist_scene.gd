extends Node
class_name Checklist

@export var Name: String

@export var Checks: Dictionary[Task, bool]
var NumToComplete: int

# Values to be loaded
var Completed: int = 0

# Tracks which quest owns it, who it belongs to, who's its DADDY!!!!
var OwningQuest: Quest
# gets changed by its owner (woof woof) to reflect whether this is the checklist the player is on currently
var IsActive: bool

func _init() -> void:
	# Says how many checks need to be completed
	NumToComplete = Checks.size() - 1
	OwningQuest = owner

func _ready() -> void:
	"# Adds requirements to dictionary
	for x in get_children():
		Checks.get_or_add(x, false)"

# When requirement completed
func increment_completed():
	OwningQuest = owner
	
	# Simple increment checking if everything's done
	if IsActive:
		if Completed < NumToComplete:
			Completed += 1
		else:
			OwningQuest.advance_stage()
