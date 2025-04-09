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
		self.health -= (value / defense / 5)
	if type == SkillResource.Damage.MAGIC:
		self.health -= (value / magicdefense / 5)
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
