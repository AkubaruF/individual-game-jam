class_name Arsenal
extends Resource

signal arsenal_changed(amount)

@export var skills: Array[SkillResource] = []
@export var items: Array[SkillResource] = []

func add(new: SkillResource):
	skills.append(new)
	arsenal_changed.emit(skills.size())
