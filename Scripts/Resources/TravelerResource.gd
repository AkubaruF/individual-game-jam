extends Resource
class_name TravelerResource

@export_category("Visuals")
@export var sprite: SpriteFrames

@export_category("Basic Info")
@export var name: String
@export var description: String

@export_category("Stats")
@export var health: int
@export var attack: int
@export var magicattack: int
@export var defense: int
@export var magicdefense: int
@export var speed: int:
	set(value):
		agility = value
		speed = 200.0 / (log(agility) + 2) - 25
		queue_reset()

var agility: float
var queue : Array[float]
var agility_modifier = 1
var node
 
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
