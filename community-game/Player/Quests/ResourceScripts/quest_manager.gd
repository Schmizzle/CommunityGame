extends Node
class_name QuestManager

@export var Quests: Array[Quest]
@export var QuestUIParent: VBoxContainer
var ExistingQuestBoxes: Dictionary[Quest, UIQuestBox]
var ExistingTaskBoxes: Dictionary[Task, UITaskBox]


func _ready() -> void:
	set_active_tasklists()
	
	create_quest_boxes()



func try_increment_task(tag: String) -> bool:
	var IncrementedSomething: bool = false
	var IncrementedTask: Task
	var TaskCompleted: bool = false
	
	var TaskListCompleted: bool
	
	var QuestChecked: Quest
	var QuestCompleted: bool = false
	
	# Looks for a task to increment
	for x in Quests:
		QuestChecked = x
		
		if x.State == x.QuestStates.Active:
			var ListToCheck: TaskList = x.ActiveTaskList
			for y in ListToCheck.Tasks:
				if y.Tag == tag:
					y.Amount += 1
					y.Amount = clamp(y.Amount, 0, y.AmountNeeded)
					IncrementedTask = y
					IncrementedSomething = true
					# UI UPDATE OF TASK INCREMENTED
					print("task of tag " + tag + " incremented")
	
	# checks if the task was completed
	if IncrementedTask.Amount >= IncrementedTask.AmountNeeded:
		IncrementedTask.Complete = true
		TaskCompleted = true
		print("task of tag " + tag + " completed")
		# UI UPDATE OF TASK GETTING COMPLETED
	
	# Checks if the active tasklist was completed
	if TaskCompleted:
		TaskListCompleted = true
		for x in QuestChecked.ActiveTaskList.Tasks:
			if not x.Complete:
				TaskListCompleted = false
				print("task list not completed")
	
	if TaskListCompleted:
		print("Whole task list completed")
		
		var CurrentQuestIndex: int
		CurrentQuestIndex = QuestChecked.TaskLists.find(QuestChecked.ActiveTaskList)
		
		# Checks if the last tasklist was completed
		if CurrentQuestIndex >= (QuestChecked.TaskLists.size() - 1):
			QuestCompleted = true
		else:
			QuestChecked.ActiveTaskList = QuestChecked.TaskLists[CurrentQuestIndex + 1]
			# UI UPDATE OF NEW ACTIVE TASKLIST
			print("Moving onto a new tasklist")
	
	if QuestCompleted:
		print("Quest of name " + QuestChecked.Name + " was completed")
		QuestChecked.State = QuestChecked.QuestStates.Complete
	
	return IncrementedSomething


func set_active_tasklists():
	for x in Quests:
		if x.State == x.QuestStates.Active:
			x.ActiveTaskList = x.TaskLists[0]


func create_quest_boxes():
	for x in Quests:
		if x.State == x.QuestStates.Active:
			# FUNCTION FOR CREATING A NEW QUESTBOX HERE
			var QuestBoxScene: PackedScene = load("res://Player/UI/ui_quest_box.tscn")
			var NewQuestBox: UIQuestBox = QuestBoxScene.instantiate()
			QuestUIParent.add_child(NewQuestBox)
			
			NewQuestBox.NameLabel.text = x.Name
			NewQuestBox.DescriptionLabel.text = x.Description
			NewQuestBox.TaskListLabel.text = x.ActiveTaskList.Description
			
			ExistingQuestBoxes.get_or_add(x, NewQuestBox)
