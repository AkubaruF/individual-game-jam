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

func is_single_targeted() -> bool:
	return target == Target.ENEMY
