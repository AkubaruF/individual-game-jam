extends SkillState

func enter() -> void:
	if not skill_ui.is_node_ready():
		await skill_ui.ready
	
	skill_ui.reparent_requested.emit(skill_ui)
	print("clicked")
	
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
