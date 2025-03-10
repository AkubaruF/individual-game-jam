extends Node
class_name SkillClass

var SkillsResource: SkillClass
var actions: int

func _init(pSkillsResource: SkillClass, pactions: int) -> void:
	SkillsResource = pSkillsResource
	actions = pactions
