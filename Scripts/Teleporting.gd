extends State

@onready var animation: AnimationPlayer = $"../../AnimationPlayer"
@onready var player: CharacterBody2D = $"../.."
var finished: bool = false

func Update(_delta: float):
	if player.velocity == Vector2(0, 0) and finished == true:
		transition_idle.emit()
	if player.velocity.y != 0 and finished == true:
		transition_jump.emit()
	if player.velocity.x != 0 and player.is_on_floor() and finished == true:
		transition_move.emit()
		
func Enter():
	finished = false
	animation.play("Teleport")
	#animation.connect("animation_finished", _on_teleport_finished)
	
func Exit():
	animation.stop()
	#
#func _on_teleport_finished():
	#print("CEVAVAVAVAVAVAVAVAAVAAVA")
	#if animation.animation == "teleporting":
		#finished = true

func _on_animation_player_animation_finished(anim_name):
	print(anim_name)
	if anim_name == "Teleport":
		finished = true
