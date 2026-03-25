extends Node3D

enum CycleTime { Day, Evening, Night }
@onready var dir_light: DirectionalLight3D = $DirectionalLight3D
@onready var world_env: WorldEnvironment = $WorldEnvironment
@export var time_current: CycleTime = CycleTime.Day

signal new_day

@export var MAT_SKY_DAY: PanoramaSkyMaterial = preload("uid://b6yd2a7nvk85v")
@export var MAT_SKY_EVENING: PanoramaSkyMaterial  = preload("uid://wqp2o4n8320u")
@export var  MAT_SKY_NIGHT: PanoramaSkyMaterial  = preload("uid://s6xnpvjovl38")

func _ready() -> void:
	time_set_day(time_current)
	Dialogic.signal_event.connect(dialogic_advance_day)
	
func dialogic_advance_day(text: String) -> void:
	if text == "advance_day":
		advance_day()

func advance_day() -> void:
	time_current+= 1
	if time_current > 2:
		time_current = 0
		new_day.emit()
	time_set_day(time_current)

func time_set_day(newTime: CycleTime):
	time_current = newTime
	match time_current:
		CycleTime.Day:
			world_env.environment.sky.sky_material = MAT_SKY_DAY
		CycleTime.Evening:
			world_env.environment.sky.sky_material = MAT_SKY_EVENING
		CycleTime.Night:
			world_env.environment.sky.sky_material = MAT_SKY_NIGHT


func _on_bed_sleep() -> void:
	advance_day()
