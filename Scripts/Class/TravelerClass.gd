extends Node
class_name TravelerClass

var StatsResource: StatsResource
var Level: int
var CurrentHealth : int
var LearnedSkills: Array[SkillClass]

func _init(pTravelerResouce: StatsResource, plevel: int) -> void:
	StatsResource = pTravelerResouce
	CurrentHealth = pTravelerResouce.health
	Level = plevel
	LearnedSkills = []
