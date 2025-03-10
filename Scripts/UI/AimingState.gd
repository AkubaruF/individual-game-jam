extends SkillState

func enter() -> void:
	if not skill_ui.is_node_ready():
		await skill_ui.ready
	
	skill_ui.reparent_requested.emit(skill_ui)
	print("hello	")
	
func exit() -> void:
	pass

func on_input(event: InputEvent) -> void:
	pass
	
func on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		transition_requested.emit(self, SkillState.State.AIMING)

func on_mouse_entered() -> void:
	pass
	
func on_mouse_exited() -> void:
	pass
