extends VBoxContainer
class_name QuestBox

var RelatedQuest: Quest


@export var QName: Label
@export var QDescription: Label
@export var CName: Label


func _ready() -> void:
	update_display()

func update_display():
	QName.text = RelatedQuest.Name
	QDescription.text = RelatedQuest.Description
	CName.text = RelatedQuest.Stages[RelatedQuest.CurrentStage].Name
