extends Resource
class_name StatsResource

signal stats_changed

@export_category("Visuals")
@export var sprite: SpriteFrames
@export var icon: Texture2D

@export_category("Basic Info")
@export var name: String

@export_category("Stats")
@export var maxhealth: int
@export var attack: int
@export var magicattack: int
@export var defense: int
@export var magicdefense: int
@export var speed: int:
	set(value):
		agility = value
		speed = 200.0 / (log(agility) + 2) - 25
		stats_changed.emit()
		queue_reset()

var agility: float
var queue : Array[float]
var agility_modifier = 1
var health: int: set = set_health

func set_health(value: int) -> void:
	health = clampi(value,0,maxhealth)
	stats_changed.emit()

func health_change(value: int) -> void:
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
