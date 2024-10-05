extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -300.0
const MAX_HEIGHT: int = 30
var jump_buffer: bool = false
var coyote_frames: int = 8
var jumped: bool = false
var can_teleport: bool = true
var spawn_landing_particle: bool = false
@export var teleport_cooldown: bool = true
@export var teleport_particle = preload("res://Scenes/teleport_particle.tscn")
@export var landing_particle = preload("res://Scenes/landing_particle.tscn")
@onready var buffer: RayCast2D = $RayCast2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$"../NoTeleportAreas".connect("mouse_enter", _on_mouse_enter)
	$"../NoTeleportAreas".connect("mouse_exit", _on_mouse_exit)
	if not is_on_floor():
		velocity.y += gravity

func _physics_process(delta):
	if Input.is_action_just_pressed("teleport") and can_teleport and teleport_cooldown:
		var particle = teleport_particle.instantiate()
		#particle.translation = Vector2(position)
		particle.set_position($ParticlePosition.global_position)
		get_parent().add_child(particle)
		particle.restart()
		position += $".".get_local_mouse_position()
		$TeleportCooldown.start()
		teleport_cooldown = false
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
		spawn_landing_particle = true
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
	if spawn_landing_particle == true and is_on_floor():
		var l_particle = landing_particle.instantiate()
		if Input.is_action_pressed("Left"):
			l_particle.gravity.x = -900
		elif Input.is_action_pressed("Right"):
			l_particle.gravity.x = 900
		spawn_landing_particle = false
		l_particle.set_position($LandingParticlePosition.global_position)
		get_parent().add_child(l_particle)
		l_particle.restart()
		print("BOOYA")
	move_and_slide()

func _on_teleport_cooldown_timeout():
	teleport_cooldown = true

func _on_mouse_exit():
	can_teleport = true
	
func _on_mouse_enter():
	can_teleport = false
