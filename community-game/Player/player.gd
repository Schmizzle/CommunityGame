extends CharacterBody3D
class_name Player

var GameManagerNode: GameManager

# Movement variables
var Direction: Vector3
var LerpedDirection: Vector3
var TargetVelocity: Vector3
@export var MaxSpeed: int = 7
@export var InitialSpeed: int = 2
var CurrentSpeed: float = 0
var TargetSpeed: float = 0
var SpeedLerpStep: float = 5
var Braking: bool = false

var CanMove: bool = true
var InputtingMovement: bool = false
var InMovement: bool = false

var Gravity: float = 0.4
var JumpForce: int = 10


# Look variables
var CanLook: bool = true
@export var Sensitivity: float = 0.3
var ControllerLookMultiplier: float = 2
var LookRotation: Vector2 = Vector2.ZERO
@export var LookPivot: Node3D
var YRotationDirection: float

@export_group("UI References")
@export var UIReference: Control
@export var InteractUI: Label
@export var QuestContainer: VBoxContainer

@export_group("Quest stuff")
@export var QuestManagerNode: QuestManager

@export_group("Camera stuff")
@export var CameraManagerNode: CameraManager
@export var FPCamera: Camera3D
var UsingFixedCamera: bool = false

@export_group("")
@export var InteractCast: ShapeCast3D


func _ready() -> void:
	# Captures the player mouse, making it hidden and centered in the window
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	Globals.PlayerReference = self
	
	GameManagerNode = get_tree().get_first_node_in_group("GameManager")
	CameraManagerNode = GameManagerNode.CameraManagerNode
	QuestManagerNode = GameManagerNode.QuestManagerNode
	QuestManagerNode.QuestUIParent = QuestContainer
	QuestManagerNode.create_quest_boxes()


func _process(_delta: float) -> void:
#region Input
	
#region Moving
	# Gets the player's movement input
	var InputVector: Vector2
	InputVector = Input.get_vector("move-left", "move-right","move-forward","move-backward")
	var InputVector3: Vector3 = Vector3(InputVector.x, 0, InputVector.y).rotated(Vector3.UP, YRotationDirection).normalized()
	
	if UsingFixedCamera:
		if Direction == Vector3.ZERO:
			YRotationDirection = CameraManagerNode.CurrentCamera.global_rotation.y
	else:
		YRotationDirection = LookPivot.global_rotation.y
	
	InputtingMovement = InputVector != Vector2.ZERO
	InMovement = CurrentSpeed == 0
	
	if InputtingMovement and (not InMovement):
		Direction = InputVector3
	elif InputtingMovement:
		Direction = Direction.move_toward(InputVector3, .01)
	
	# checking what to set the speeds to
	# if the player is inputting movement and sets the target speed
	if InputtingMovement:
		TargetSpeed = MaxSpeed
		# checks if the player is below the minimal push speed and pushes them up if not
		if CurrentSpeed < InitialSpeed:
			CurrentSpeed = InitialSpeed
	else:
		TargetSpeed = 0
	
	var Step: float
	if Braking:
		Step = 0.5
	else:
		Step = 0.1
	
	CurrentSpeed = move_toward(CurrentSpeed, TargetSpeed, Step)
	CurrentSpeed = clamp(CurrentSpeed, 0, MaxSpeed)
	
	print(CurrentSpeed, " ", TargetSpeed, " ", InputtingMovement, " ", InMovement)
	# print(Direction)
	
	# Sets the horizontal components of target velocity if the character can move, completely stops them if not
	if CanMove:
		TargetVelocity.x = Direction.x * CurrentSpeed
		TargetVelocity.z = Direction.z * CurrentSpeed
	else:
		TargetVelocity.x = 0
		TargetVelocity.z = 0
	
	# Makes the player fall if they're not on the floor
	if not is_on_floor():
		TargetVelocity.y -= Gravity
	else:
		TargetVelocity.y = 0
	
	# lets the player jump
	if is_on_floor() and Input.is_action_just_pressed("jump") and CanMove:
		TargetVelocity.y = JumpForce
	
	# Sets velocity to be the target velocity and moves the player according to it
	velocity = TargetVelocity
	move_and_slide()
#endregion
	
#region Looking
	if CanLook:
		if not UsingFixedCamera:
			var LookVector = Input.get_vector("look_left","look_right","look_up","look_down")
			add_look_rotation(LookVector * ControllerLookMultiplier)
			
			rotation_degrees.y = LookRotation.x
			LookPivot.rotation_degrees.x = LookRotation.y
		elif Direction != Vector3.ZERO:
			LookPivot.look_at(LookPivot.global_position + (Direction))
#endregion
	
#region Quitting
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
#endregion
	
#region Interacting
	InteractUI.visible = InteractCast.is_colliding()
	
	if Input.is_action_just_pressed("interact") and InteractCast.is_colliding():
		InteractCast.get_collider(0).call("on_interacted")
#endregion
	
#endregion
	

func _input(event):
#region Getting mouse look data
	if event is InputEventMouseMotion:
		add_look_rotation(event.relative)
#endregion

func add_look_rotation(vector: Vector2):
	LookRotation.y -= (vector.y * Sensitivity)
	LookRotation.x -= (vector.x * Sensitivity)
	LookRotation.y = clamp(LookRotation.y, -75, 89)

func change_input_enabled(move: bool, look: bool, mouseMode: Input.MouseMode) -> void:
	Input.set_mouse_mode(mouseMode)
	CanMove = move
	CanLook = look

func switch_to_fp_camera():
	FPCamera.make_current()
	UsingFixedCamera = false

func switch_to_fixed_camera():
	UsingFixedCamera = true

func push_off():
	CurrentSpeed 
	CurrentSpeed = clamp(CurrentSpeed, 0, MaxSpeed)


func _on_area_3d_body_entered(body: Node3D) -> void:
	TargetVelocity.y  = 30
