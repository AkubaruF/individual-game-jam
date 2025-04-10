extends Control

func _ready() -> void:
	play_all_animated_sprites(self)

func _on_play_button_pressed() -> void:
	Events.gold_run = 6
	get_tree().change_scene_to_file(str("res://Scene/Level.tscn"))

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func play_all_animated_sprites(node: Node) -> void:
	if node is AnimatedSprite2D:
		node.play("idle")
	
	for child in node.get_children():
		play_all_animated_sprites(child)
