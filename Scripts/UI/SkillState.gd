class_name SkillState
extends Node

enum State {BASE, CLICKED, AIMING}

signal transition_requested(from: SkillState, to: State)
@export var state: State
var skill_ui: SkillUI

func enter() -> void:
	pass
	
func exit() -> void:
	pass

func on_input(event: InputEvent) -> void:
	pass
	
func on_gui_input(event: InputEvent) -> void:
	pass

func on_mouse_entered() -> void:
	pass
	
func on_mouse_exited() -> void:
	pass
