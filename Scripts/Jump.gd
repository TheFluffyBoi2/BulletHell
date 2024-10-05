extends State

@onready var animation: AnimationPlayer = $"../../AnimationPlayer"
@onready var player: CharacterBody2D = $"../.."
@onready var sprite: Sprite2D = $"../../Sprite2D"

func Physics_Update(_delta: float):
	if Input.is_action_just_pressed("Left"):
		sprite.flip_h = true
	if Input.is_action_just_pressed("Right"):
		sprite.flip_h = false

func Update(_delta: float):
	if player.velocity.x == 0 and player.velocity.y == 0:
		transition_idle.emit()
	if player.velocity.y == 0 and player.velocity.x != 0:
		transition_move.emit()
	if Input.is_action_just_pressed("teleport") and player.can_teleport == true:
		transition_teleport.emit()
	
func Enter():
	if Input.is_action_just_pressed("Left"):
		sprite.flip_h = true
	if Input.is_action_just_pressed("Right"):
		sprite.flip_h = false
	animation.play("Jump")
	
func Exit():
	animation.stop()
