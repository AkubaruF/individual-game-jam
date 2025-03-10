extends Resource
class_name SkillResource

enum Type {ATTACK, SKILL, ITEM}
enum Rarity {COMMON, UNCOMMON, RARE}
enum Target {SELF, ALL_ALLY, SINGLE_ENEMY,ALL_ENEMIES, EVERYONE}

const RARITY_COLORS := {
	SkillResource.Rarity.COMMON: Color.GRAY,
	SkillResource.Rarity.UNCOMMON: Color.CORNFLOWER_BLUE,
	SkillResource.Rarity.RARE: Color.GOLD,
}

@export_category("Basic Info")
@export var id: String
@export var type: Type
@export var rarity: Rarity
@export var target: Target
@export var name: String
@export var description: String

func is_single_targeted() -> bool:
	return target == Target.SINGLE_ENEMY
