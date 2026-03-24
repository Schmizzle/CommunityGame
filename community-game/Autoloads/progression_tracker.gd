extends Node

enum QuestTags {
	NaN, 
	Test, 
	Sleepy,
	Deliver_Water
	}

enum TasklistTags {
	NaN, 
	Test_OrbClicking, Test_SodaDrinking,
	Sleepy_Lavender, Sleepy_SlothWax, Sleepy_EssenceOfMoonlight,
	Deliver_Water_Meet, Deliver_Water_Collect, Deliver_Water_Deliver,
	}

enum TaskTags {
	NaN, 
	Test_Orb1, Test_Orb2, Test_SodaDrink,
	Deliver_Water_Meet, Deliver_Water_Collect, Deliver_Water_Deliver, 
	}

var TestBool: bool = true


func try_increment_task(tag: TaskTags):
	var GameManagerNode: GameManager = get_tree().get_first_node_in_group("GameManager")
	GameManagerNode.QuestManagerNode.try_increment_task(tag)
