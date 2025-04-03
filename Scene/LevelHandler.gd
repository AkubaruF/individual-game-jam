extends Node
 
@export var player_group : Node2D
@export var enemy_group : Node2D
@export var timeline : Control
  
var sorted_array = []
var players : Array[StatsResource]
var enemies : Array[StatsResource]

func _ready():
	for player in player_group.get_children():
		players.append(player.characterStat)
 
	for enemy in enemy_group.get_children():
		enemies.append(enemy.statsResource)
 
	sort_and_display()
	Events.next_attack.connect(next_attack)
  
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
		slot.find_child("TextureRect").texture = sorted_array[index]["character"].icon
		index += 1
 
func sort_and_display():
	sort_combined_queue()
	update_timeline()
	if sorted_array[0]["character"] in players:
		pass
	else:
		var level = get_tree().current_scene
		level.find_child("HUD").hide()
		level.find_child("Enemy").play("attack1")
		await level.find_child("Enemy").animation_finished
		level.find_child("Enemy").play("idle")
		level.find_child("HUD").show()
		level.find_child("HUD").focus_first_button()
		next_attack()
 
func pop_out():
	sorted_array[0]["character"].pop_out()
	sort_and_display()
 
func next_attack():
	pop_out()
 
func set_status(status_type):
	sorted_array[0]["character"].set_status(status_type)
	sort_and_display()
