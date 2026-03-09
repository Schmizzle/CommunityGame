extends Node

@export var TestQuest = Quest.new()


class Quest extends Resource:
	var Name: String
	var Description: String
	var Completed: bool
	var Stages: Array[Checklist]
	
	var CurrentStage: int


class Checklist extends Resource:
	var Checks: Array[Requirement]


class Requirement extends Resource:
	var Name: String
	var Completed: bool
	var Description: String
