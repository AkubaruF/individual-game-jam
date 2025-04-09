extends Node
 
@export var player_group : Node2D
@export var enemy_group : Node2D
@export var timeline : Control

var level
var selected_skills
var stats : CharacterStat
var targets: Array[Node] = []

var sorted_array = []
var players : Array[StatsResource]
var enemies : Array[StatsResource]

var enemySkills: Array[SkillResource] = []

func _ready():
	randomize()
	level = get_tree().current_scene
	load_enemy_skills()
	selected_skills = get_random_enemy_skills()
	for player in player_group.get_children():
		players.append(player.characterStat)
 
	for enemy in enemy_group.get_children():
		enemies.append(enemy.statsResource)
 
	sort_and_display()
	Events.next_attack.connect(next_attack)

func load_enemy_skills():
	var dir := DirAccess.open("res://Game/Skills/")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir() and file_name.ends_with(".tres"): # or .res
				var full_path = "res://Game/Skills/" + file_name
				var res = ResourceLoader.load(full_path)
				if res is SkillResource:
					enemySkills.append(res)
			file_name = dir.get_next()
		dir.list_dir_end()
  
func sort_combined_queue():
	var player_array = []
	for player in players:
		for i in player.queue:
			player_array.append({"character" : player, "time": i})
 
	var enemy_array = []
	for enemy in enemies:
		for i in enemy.queue:
			enemy_array.append({"character" : enemy, "time": i})
 
	sorted_array = player_array
	sorted_array.append_array(enemy_array)
	sorted_array.sort_custom(sort_by_time)
 
func sort_by_time(a,b):
	return a["time"] < b["time"]
 
func update_timeline():
	var index : int = 0
	for slot in timeline.find_child("TimelineContainer").get_children():
		var texture_rect = slot.find_child("TextureRect")

		texture_rect.texture = sorted_array[index]["character"].icon
		texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		texture_rect.expand = true
		texture_rect.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		texture_rect.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		texture_rect.custom_minimum_size = Vector2(48, 48)
		index += 1
 
func sort_and_display():
	sort_combined_queue()
	update_timeline()
	if sorted_array[0]["character"] in players:
		level = get_tree().current_scene
		level.find_child("HUD").show()
		level.find_child("HUD").focus_first_button()
	else:
		level = get_tree().current_scene
		level.find_child("HUD").hide()
		enemy_play_skill()

func enemy_play_skill():
	print(selected_skills)
	var skill = selected_skills[randi() % selected_skills.size()]
	print(skill.name)
	if skill.target == SkillResource.Target.SELF:
		targets = [level.find_child("EnemyTeam", true, false).get_child(0)]
	elif skill.target == SkillResource.Target.ENEMY:
		targets = [level.find_child("PlayerTeam", true, false).get_child(0)]
	elif skill.target == SkillResource.Target.EVERYONE:
		targets = [level.find_child("PlayerTeam", true, false).get_child(0),level.find_child("EnemyTeam", true, false).get_child(0)]
	if not skill:
		return
	
	var enemy = level.find_child("EnemyTeam", true, false).get_child(0)
	if not (enemy is Enemy):
		return
	enemy.play("attack1")
	await enemy.animation_finished
	skill.play(targets, enemy.statsResource)
	enemy.play("idle")

func get_random_enemy_skills(count: int = 4) -> Array[SkillResource]:
	if enemySkills.size() == 0:
		return []

	var shuffled = enemySkills.duplicate()
	shuffled.shuffle()
	return shuffled.slice(0, min(count, shuffled.size()))
	
func pop_out():
	sorted_array[0]["character"].pop_out()
	sort_and_display()
 
func next_attack():
	pop_out()

func set_status(status_type):
	sorted_array[0]["character"].set_status(status_type)
	sort_and_display()
