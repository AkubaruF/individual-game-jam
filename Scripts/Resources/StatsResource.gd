extends Resource
class_name StatsResource

signal stats_changed

@export_category("Visuals")
@export var sprite: SpriteFrames
@export var icon: Texture2D

@export_category("Basic Info")
@export var name: String

@export_category("Stats")
@export var maxhealth: int:
	set(value):
		maxhealth = value
		stats_changed.emit()
@export var attack: int:
	set(value):
		attack = value
		stats_changed.emit()
@export var magicattack: int:
	set(value):
		magicattack = value
		stats_changed.emit()
@export var defense: int:
	set(value):
		defense = value
		stats_changed.emit()
@export var magicdefense: int:
	set(value):
		magicdefense = value
		stats_changed.emit()
@export var speed: int:
	set(value):
		speed = value
		agility = 200.0 / (log(speed) + 2) - 25
		stats_changed.emit()
		queue_reset()

var agility: float
var queue : Array[float]
var agility_modifier = 1
var health: int: set = set_health

func set_health(value: int) -> void:
	health = clampi(value,0,maxhealth)
	stats_changed.emit()

func damage(value: int, type: SkillResource.Damage) -> void:
	if type == SkillResource.Damage.PHYSICAL:
		self.health -= (value / defense / 10)
	if type == SkillResource.Damage.MAGIC:
		self.health -= (value / magicdefense / 10)
	stats_changed.emit()

func heal(value: int, type: SkillResource.Damage) -> void:
	self.health += value
	stats_changed.emit()

func queue_reset():
	queue.clear()
	for i in range(4):
		if queue.size() == 0:
			queue.append(agility * agility_modifier)
		else:
			queue.append(queue[-1] + agility * agility_modifier)

func pop_out():
	queue.pop_front()
	queue.append(queue[-1] + agility * agility_modifier)
	
func set_status(status_type : String):
	match status_type:
		"Haste":
			agility_modifier = 0.5
		"Slow":
			agility_modifier = 2
 
	for i in range(3):
		queue.pop_back()
 
	for i in range(3):
		queue.append(queue[-1] + agility * agility_modifier)

func create_instance() -> Resource:
	var instance: StatsResource = self.duplicate()
	instance.health = maxhealth
	return instance

func randomize_stats_with_bonus():
	var stat_keys = ["maxhealth", "attack", "magicattack", "defense", "magicdefense", "speed"]
	var original_values = {
		"maxhealth": maxhealth,
		"attack": attack,
		"magicattack": magicattack,
		"defense": defense,
		"magicdefense": magicdefense,
		"speed": speed
	}

	var total = 0
	for key in stat_keys:
		total += original_values[key]

	var increased_total = int(round(total * 1.1))
	
	# Give each stat at least 1
	var new_values = {}
	for key in stat_keys:
		new_values[key] = 1
	increased_total -= stat_keys.size()

	# Randomly assign the rest
	for i in range(increased_total):
		var rand_key = stat_keys[randi() % stat_keys.size()]
		new_values[rand_key] += 1

	# Apply and trigger setters
	maxhealth = new_values["maxhealth"]
	attack = new_values["attack"]
	magicattack = new_values["magicattack"]
	defense = new_values["defense"]
	magicdefense = new_values["magicdefense"]
	speed = new_values["speed"]
