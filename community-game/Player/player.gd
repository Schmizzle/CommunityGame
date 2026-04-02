extends CharacterBody3D
class_name Player

var GameManagerNode: GameManager

# Movement variables
var CanMove: bool = true
@export var Speed: int = 700
var Gravity: int = 20
var JumpForce: int = 7
var Direction: Vector3
var TargetVelocity: Vector3

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


func _process(delta: float) -> void:
#region Input
	
#region Moving
	# Gets the player's movement input
	var InputDirection: Vector2
	
	if UsingFixedCamera:
		if Direction == Vector3.ZERO:
			YRotationDirection = CameraManagerNode.CurrentCamera.global_rotation.y
	else:
		YRotationDirection = LookPivot.global_rotation.y
	
	InputDirection = Input.get_vector("move-left", "move-right","move-forward","move-backward")
	Direction = Vector3(InputDirection.x, 0, InputDirection.y).rotated(Vector3.UP, YRotationDirection)
	
	# Sets the horizontal components of target velocity
	if CanMove:
		TargetVelocity.x = Direction.x * Speed * delta
		TargetVelocity.z = Direction.z * Speed * delta
	
	# Makes the player fall if they're not on the floor
	if not is_on_floor():
		TargetVelocity.y -= Gravity * delta
	"else:
		TargetVelocity.y = 0"
	
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


func _on_area_3d_body_entered(body: Node3D) -> void:
	TargetVelocity.y  = 30
