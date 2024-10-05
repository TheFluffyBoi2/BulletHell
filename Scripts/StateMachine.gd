extends Node

@export var current_state: State
var states: Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.connect("transition_idle", idle_transition)
			child.connect("transition_move", move_transition)
			child.connect("transition_jump", jump_transition)
			child.connect("transition_teleport", teleport_transition)

func _process(delta):
	if current_state:
		current_state.Update(delta)
		
func _physics_process(delta):
	if current_state:
		current_state.Physics_Update(delta)

func idle_transition():
	current_state.Exit()
	current_state = states["idle"]
	current_state.Enter()
	
func jump_transition():
	current_state.Exit()
	current_state = states["jump"]
	current_state.Enter()
	
func move_transition():
	current_state.Exit()
	current_state = states["move"]
	current_state.Enter()
	
func teleport_transition():
	current_state.Exit()
	current_state = states["teleporting"]
	current_state.Enter()
