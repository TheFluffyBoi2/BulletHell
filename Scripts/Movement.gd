extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -300.0
const MAX_HEIGHT: int = 30
var jump_buffer: bool = false
var coyote_frames: int = 10
var jumped: bool = false
var can_dash: bool = true
@onready var dash_cooldown: Timer = $DashCooldown
@onready var buffer: RayCast2D = $RayCast2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	if not is_on_floor():
		velocity.y += gravity

func _physics_process(delta):
	print($".".position)
	if Input.is_action_just_pressed("teleport"):
		#print($Area2D.get_local_mouse_position())
		position = $".".get_local_mouse_position()
	var direction = Input.get_axis("Left", "Right")
	if is_on_floor():
		coyote_frames = 10
		jumped = false
	if not is_on_floor() and coyote_frames > 0:
		coyote_frames -= 1
	if Input.is_action_just_pressed("Jump") and coyote_frames > 0 and jumped == false:
		velocity.y = JUMP_VELOCITY
	if (Input.is_action_just_pressed("Jump") and is_on_floor()):
		velocity.y = JUMP_VELOCITY
		jumped = true
	if not is_on_floor():
		if Input.is_action_pressed("Fall"):
			gravity *= 1.1
		else:
			gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
		velocity.y += gravity * delta
		if buffer.is_colliding() and Input.is_action_just_pressed("Jump"):
			jump_buffer = true
	if jump_buffer and is_on_floor():
		jump_buffer = false
		velocity.y = JUMP_VELOCITY
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = direction * -SPEED

	move_and_slide()
