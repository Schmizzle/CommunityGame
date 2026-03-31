extends Sprite3D

var time: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(time)
	time = 0+$".".global_position.x*0.3


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	$".".rotation = Vector3(0,0,0.15*sin(time))
