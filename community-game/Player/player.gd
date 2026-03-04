extends CharacterBody3D
class_name Player

# Movement variables
@export var Speed: int = 700
var InputDirection: Vector2 = Vector2.ZERO
var Direction: Vector3 = Vector3.ZERO
var TargetVelocity: Vector3 = Vector3.ZERO
var Gravity: int = 20
var JumpForce: int = 7

# Mouse look variables
var MouseVelocity: Vector2 = Vector2.ZERO
var Sensitivity: float = 0.3
var LookRotation: Vector2 = Vector2.ZERO
@export var CameraPivot: Node3D

# Interacting variables
@export var InteractCast: RayCast3D
@export var InteractUI: Label


func _ready() -> void:
	# Captures the player mouse, making it hidden and centered in the window
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _process(delta: float) -> void:
#region Moving
	# Gets the player's movement input
	InputDirection = Input.get_vector("move-backward","move-forward","move-right","move-left")
	Direction = (transform.basis * Vector3(InputDirection.x, 0, InputDirection.y)).normalized()
	
	# Sets the horizontal components of target velocity
	TargetVelocity.x = Direction.x * Speed * delta
	TargetVelocity.z = Direction.z * Speed * delta
	
	# Makes the player fall if they're not on the floor
	if not is_on_floor():
		TargetVelocity.y -= Gravity * delta
	else:
		TargetVelocity.y = 0
	
	# lets the player jump
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		TargetVelocity.y = JumpForce
	
	# Sets velocity to be the target velocity and moves the player according to it
	velocity = TargetVelocity
	move_and_slide()
#endregion
	
#region Looking
	rotation_degrees.y = LookRotation.x
	CameraPivot.rotation_degrees.z = LookRotation.y
#endregion
	
#region Quitting
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
#endregion
	
#region Interacting
	var DetectingInteractable: bool = InteractCast.get_collider() != null
	InteractUI.visible = DetectingInteractable
	var DetectedInteractable = InteractCast.get_collider()
	
	if Input.is_action_just_pressed("interact") and DetectingInteractable:
		InteractCast.get_collider().call("on_interacted")
#endregion
	
	


func _input(event):
#region Getting mouse look data
	if event is InputEventMouseMotion:
		LookRotation.y -= (event.relative.y * Sensitivity)
		LookRotation.x -= (event.relative.x * Sensitivity)
		LookRotation.y = clamp(LookRotation.y, -75, 89)
#endregion
		
