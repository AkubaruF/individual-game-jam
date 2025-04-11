extends Node
 
@export var player_group : Node2D
@export var enemy_group : Node2D
@export var enemy_original : Enemy
@export var timeline : Control
@export var audioPlayer: AudioStreamPlayer
@export var sfx: AudioStreamWAV

var level
var battles
var selected_skills
var tree
var stats : CharacterStat
var targets: Array[Node] = []

var sorted_array = []
var players : Array[StatsResource]
var enemies : Array[StatsResource]

@export var enemySkills: Array[SkillResource]

func _ready():
	tree = get_tree()
	Events.enemy_died_count = 0
	randomize()
	level = get_tree().current_scene
	for player in player_group.get_children():
		players.append(player.characterStat)
 
	for enemy in enemy_group.get_children():
		enemies.append(enemy.statsResource)
	Events.next_attack.connect(next_attack)
	Events.enemy_died.connect(start_battle)
	start_battle()

func start_battle():
	selected_skills = get_random_enemy_skills()

	sort_and_display()
  
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
	level.find_child("HUD").show()
	if level.find_child("EnemyTeam", true, false).get_child(0).visible == false:
		return
	elif sorted_array[0]["character"] in players:
		level.find_child("HUD").show()
		toggle_focus(true)
	elif sorted_array[0]["character"] in enemies:
		level.find_child("HUD").hide()
		enemy_play_skill()
	else:
		next_attack()

func toggle_focus(condition: bool):
	if condition:
		level.find_child("HUD").focus_first_button()

func enemy_play_skill():
	var skill = selected_skills[randi() % selected_skills.size()]
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
	enemy_original.play("attack1")
	if is_inside_tree():
		var tree := get_tree()
		await tree.create_timer(0.5).timeout
		await tree.process_frame
		await tree.process_frame
	skill.play(targets, enemy.statsResource)
	enemy_original.play("idle")

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
	_play_music_with_random_pitch()
	pop_out()

func set_mouse_input_on_all(node: Control, enabled: bool) -> void:
	if node is NinePatchRect or node is RichTextLabel:
		node.mouse_filter = Control.MOUSE_FILTER_IGNORE
	else:
		if enabled:
			node.mouse_filter = Control.MOUSE_FILTER_STOP
		else:
			node.mouse_filter = Control.MOUSE_FILTER_IGNORE

	for child in node.get_children():
		if child is Control:
			set_mouse_input_on_all(child, enabled)

func _play_music_with_random_pitch():
	var audio := AudioStreamPlayer.new()
	audioPlayer.stream = sfx
	audioPlayer.pitch_scale = randf_range(0.85, 1.0)
	audioPlayer.play()
