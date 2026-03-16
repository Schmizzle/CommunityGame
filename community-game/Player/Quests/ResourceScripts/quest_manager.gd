extends Node
class_name QuestManager

@export var Quests: Array[Quest]
@export var QuestUIParent: VBoxContainer
var ExistingQuestBoxes: Dictionary[Quest, UIQuestBox]
var ExistingTaskBoxes: Dictionary[Task, UITaskBox]


func _ready() -> void:
	set_active_tasklists()
	
	create_quest_boxes()


func activate_quest(id: int):
	pass


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
					
					update_task_display(y)
					print("task of tag " + tag + " incremented")
	
	# checks if the task was completed
	if IncrementedTask != null:
		if IncrementedTask.Amount >= IncrementedTask.AmountNeeded:
			IncrementedTask.Complete = true
			TaskCompleted = true
			print("task of tag " + tag + " completed")
	
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
			# Deletes all the completed task UI
			clear_task_boxes(QuestChecked.ActiveTaskList)
			# Advances the active tasklist forward
			QuestChecked.ActiveTaskList = QuestChecked.TaskLists[CurrentQuestIndex + 1]
			# Creates new tasks based on the new active tasklist
			create_task_boxes(QuestChecked)
			# Updates the name of the tasklist
			update_tasklist_display(QuestChecked)
			print("Moving onto a new tasklist")
	
	if QuestCompleted:
		print("Quest of name " + QuestChecked.Name + " was completed")
		QuestChecked.State = QuestChecked.QuestStates.Complete
		remove_quest_box(QuestChecked)
	
	return IncrementedSomething

# TEMPORARY UNTIL WE HAVE ACTUAL DATA LOADING
func set_active_tasklists():
	for x in Quests:
		if x.State == x.QuestStates.Active:
			x.ActiveTaskList = x.TaskLists[0]


#region UI updates

func create_quest_boxes():
	for x in Quests:
		# Checks if the quest is active AND if the UI hasn't been created yet
		if (x.State == x.QuestStates.Active) and (ExistingQuestBoxes.get(x) == null):
			var QuestBoxScene: PackedScene = load("res://Player/UI/ui_quest_box.tscn")
			var NewQuestBox: UIQuestBox = QuestBoxScene.instantiate()
			
			NewQuestBox.NameLabel.text = x.Name
			NewQuestBox.DescriptionLabel.text = x.Description
			NewQuestBox.TaskListLabel.text = x.ActiveTaskList.Description
			QuestUIParent.add_child(NewQuestBox)
			
			ExistingQuestBoxes.get_or_add(x, NewQuestBox)
			
			create_task_boxes(x)


func create_task_boxes(quest: Quest):
	for x in quest.ActiveTaskList.Tasks:
		var TaskBoxScene: PackedScene = load("res://Player/UI/ui_task_box.tscn")
		var NewTaskBox: UITaskBox = TaskBoxScene.instantiate()
		
		NewTaskBox.Amount = x.Amount
		NewTaskBox.AmountNeeded = x.AmountNeeded
		NewTaskBox.DescriptionLabel.text = x.Description
		
		ExistingTaskBoxes.get_or_add(x, NewTaskBox)
		ExistingQuestBoxes[quest].TaskContainer.add_child(NewTaskBox)


func remove_quest_box(relatedQuest: Quest):
	# Clears the tasks from the dictionary, ensuring stragglers don't get left behind
	clear_task_boxes(relatedQuest.ActiveTaskList)
	# Actually erases the quest box
	ExistingQuestBoxes.get(relatedQuest).queue_free()
	ExistingQuestBoxes.erase(relatedQuest)


func clear_task_boxes(taskList: TaskList):
	# Erases all the task boxes within the specified tasklist
	for x in taskList.Tasks:
		ExistingTaskBoxes[x].queue_free()
		ExistingTaskBoxes.erase(x)


func update_task_display(task: Task):
	ExistingTaskBoxes[task].update_task_display(task.Amount)


func update_tasklist_display(quest: Quest):
	ExistingQuestBoxes[quest].TaskListLabel.text = quest.ActiveTaskList.Description

#endregion


#region Queries WIP!!!!!

"func query_tasklist_complete(tag: String) -> bool:
	var ReturnValue: bool = false
	
	for x in Quests:
		for y in x.TaskLists:
			if y.
	
	return ReturnValue"

#endregion
