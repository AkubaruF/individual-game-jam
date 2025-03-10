extends Node
class_name TravelerClass

var TravelerResource: TravelerResource
var Level: int
var CurrentHealth : int
var LearnedSkills: Array[SkillClass]

func _init(pTravelerResouce: TravelerResource, plevel: int) -> void:
	TravelerResource = pTravelerResouce
	CurrentHealth = pTravelerResouce.health
	Level = plevel
	LearnedSkills = []
