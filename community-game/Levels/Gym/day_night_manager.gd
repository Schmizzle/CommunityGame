extends Node3D

enum CycleTime { Day, Evening, Night }
@onready var dir_light: DirectionalLight3D = $DirectionalLight3D
@onready var world_env: WorldEnvironment = $WorldEnvironment
@export var time_current: CycleTime = CycleTime.Day

@export var MAT_SKY_DAY: PanoramaSkyMaterial = preload("uid://b6yd2a7nvk85v")
@export var MAT_SKY_EVENING: PanoramaSkyMaterial  = preload("uid://wqp2o4n8320u")
@export var  MAT_SKY_NIGHT: PanoramaSkyMaterial  = preload("uid://s6xnpvjovl38")

func _ready() -> void:
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
