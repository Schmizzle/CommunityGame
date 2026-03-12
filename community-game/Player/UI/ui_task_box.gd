extends HBoxContainer
class_name UITaskBox

@export var CheckMark: TextureRect
@export var DoneSprite: CompressedTexture2D
@export var NotDoneSprite: CompressedTexture2D

@export var AmountLabel: Label
@export var DescriptionLabel: Label

var AmountNeeded: int
var Amount: int

func _ready() -> void:
	if AmountNeeded == 1:
		AmountLabel.hide()
	
	update_task_display(Amount)


func update_task_display(newAmount: int):
	Amount = newAmount
	update_amount_label(Amount, AmountNeeded)
	update_check_mark()


func update_amount_label(current: int, goal: int):
	AmountLabel.text = str(current) + "/" + str(goal)


func update_check_mark():
	if Amount >= AmountNeeded:
		CheckMark.texture = DoneSprite
	else:
		CheckMark.texture = NotDoneSprite
