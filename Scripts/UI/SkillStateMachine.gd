class_name SkillStateMachine
extends Node

@export var initial_state: SkillState

var current_state: SkillState
var states := {}

func init(skillui: SkillUI) -> void:
	for child in get_children():
		if child is SkillState:
			states[child.state] = child
			child.transition_requested.connect(_on_transition_requested)
			child.skill_ui = skillui
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state
		
func on_input(event: InputEvent) -> void:
	if current_state:
		current_state.on_input(event)
		
func on_gui_input(event: InputEvent) -> void:
	if current_state:
		current_state.on_gui_input(event)
		
func _on_transition_requested(from: SkillState, to: SkillState) -> void:
	if from != current_state:
		return
	var new_state: SkillState = states[to]
	if not new_state:
		return
	if current_state:
		current_state.exit()
	new_state.enter()
	current_state = new_state
