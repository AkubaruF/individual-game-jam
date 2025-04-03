extends Resource
class_name SkillResource

enum Type {ATTACK, SKILL, ITEM}
enum Target {SELF, ENEMY, EVERYONE}

@export_category("Basic Info")
@export var id: String
@export var type: Type
@export var target: Target
@export var name: String
@export var description: String
@export var uses: int

func play(targets: Array[Node], stat: StatsResource) -> void:
	Events.skill_played.emit(self)
	apply_effects(targets)
	Events.next_attack.emit()

func apply_effects(target: Array[Node]) -> void:
	pass
