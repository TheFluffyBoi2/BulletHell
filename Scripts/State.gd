extends Node

class_name  State

signal transition_idle
signal transition_move
signal transition_jump
signal transition_teleport

func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	pass
	
func Enter():
	pass
	
func Exit():
	pass
