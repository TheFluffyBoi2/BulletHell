extends Node

signal mouse_enter
signal mouse_exit

func _ready():
	for child in get_children():
		var area = child
		print(area)
		area.mouse_enter.connect(_on_mouse_enter)
		area.mouse_exit.connect(_on_mouse_exit)

func _process(delta):
	pass
	
func _on_mouse_enter():
	mouse_enter.emit()
	
func _on_mouse_exit():
	mouse_exit.emit()
