extends State

@onready var animation: AnimationPlayer = $"../../AnimationPlayer"
@onready var player: CharacterBody2D = $"../.."

func Update(_delta: float):
	if player.velocity.x != 0:
		transition_move.emit()
	if player.velocity.y != 0 and Input.is_action_just_pressed("Jump"):
		transition_jump.emit()
	if Input.is_action_just_pressed("teleport") and player.can_teleport == true:
		transition_teleport.emit()
	
func Enter():
	animation.play("Idle")
	
func Exit():
	animation.stop()
