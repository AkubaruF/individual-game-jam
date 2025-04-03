extends Control

var level
var character_stat
@export var button: PackedScene

func _ready() -> void:
	level = get_tree().current_scene
	character_stat = level.find_child("PlayerTeam", true, false).get_child(0)
	character_stat = character_stat.characterStat
	if character_stat:
		update_skill_buttons()

func update_skill_buttons() -> void:
	var skill_containers = [
		$SkillHUD/HBoxContainer/VBoxContainer,
		$SkillHUD/HBoxContainer/VBoxContainer2
	]
	
	var item_containers = [
		$ItemHUD/HBoxContainer/VBoxContainer,
		$ItemHUD/HBoxContainer/VBoxContainer2
	]
	for container in skill_containers:
		for child in container.get_children():
			child.queue_free()
	
	for container in item_containers:
		for child in container.get_children():
			child.queue_free()
	
	for i in range(character_stat.arsenal.skills.size()):
		var skill_resource = character_stat.arsenal.skills[i]
		if skill_resource == null:
			continue
		var skill_button = button.instantiate()
		skill_button.skill = skill_resource
		skill_button.stats = character_stat
		var container_index = i % skill_containers.size()
		skill_containers[container_index].add_child(skill_button)
		
	for i in range(character_stat.arsenal.items.size()):
		var skill_resource = character_stat.arsenal.items[i]
		if skill_resource == null:
			continue
		var skill_button = button.instantiate()
		skill_button.skill = skill_resource
		skill_button.stats = character_stat
		var container_index = i % item_containers.size()
		item_containers[container_index].add_child(skill_button)
	
	focus_first_button()

func focus_first_button() -> void:
	$SkillHUD/HBoxContainer/VBoxContainer/TextureButton.grab_focus()

# Call this function whenever CharacterStat updates
func refresh_skills(new_character_stat: CharacterStat) -> void:
	character_stat = new_character_stat
	update_skill_buttons()
