extends Node

signal skill_played(skill:SkillResource)
signal next_attack()
signal arsenal_changed()
signal enemy_died()
signal player_died()

signal shop_exited()
signal skill_buy(skill: SkillResource, cost: int)
signal stat_buy(amount: int, type: String, cost: int)

var gold_run = 6
var enemy_died_count = 0

func _ready():
	enemy_died.connect(_on_enemy_died)
	player_died.connect(_on_player_died)

func _on_enemy_died():
	enemy_died_count += 1
	if enemy_died_count == 4:
		get_tree().change_scene_to_file("res://Scene/Game/winScreen.tscn")

func _on_player_died():
	get_tree().change_scene_to_file("res://Scene/Game/LoseScreen.tscn")
