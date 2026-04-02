extends Node

enum QuestTags {
	NaN, 
	Test, 
	Sleepy,
	Deliver_Water,
	Escape,
	Postman
	}

enum TasklistTags {
	NaN, 
	Test_OrbClicking, Test_SodaDrinking,
	Sleepy_Lavender, Sleepy_SlothWax, Sleepy_EssenceOfMoonlight,
	Deliver_Water_Meet, Deliver_Water_Collect, Deliver_Water_Deliver,
	Escape_Meet, Escape_Get_Plank_Day1, Escape_Get_Plank_Day2, Escape_Get_Plank_Day3, Escape_Resolution,
	Postman_Deliver
	}

enum TaskTags {
	NaN, 
	Test_Orb1, Test_Orb2, Test_SodaDrink,
	Deliver_Water_Meet, Deliver_Water_Collect, Deliver_Water_Deliver, 
	Escape_Meet, Escape_Get_Plank_Day1, Escape_Deliver_Plank_Day1, Escape_Get_Plank_Day2, Escape_Deliver_Plank_Day2, Escape_Get_Plank_Day3, Escape_Deliver_Plank_Day3, Escape_Resolution,
	Postman_Deliver_1,Postman_Deliver_2,Postman_Deliver_3
	}

var TestBool: bool = true


func try_increment_task(tag: TaskTags):
	var GameManagerNode: GameManager = get_tree().get_first_node_in_group("GameManager")
	GameManagerNode.QuestManagerNode.try_increment_task(tag)
