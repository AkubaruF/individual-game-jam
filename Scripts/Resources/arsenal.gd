class_name Arsenal
extends Resource

@export var skills: Array[SkillResource] = []
@export var items: Array[SkillResource] = []
const MAX_ARRAY = 4

func add_skills(new: SkillResource):
	skills.append(new)
	if skills.size() > MAX_ARRAY:
		skills.remove_at(0)
	Events.arsenal_changed.emit()

func add_items(new: SkillResource):
	items.append(new)
	if items.size() > MAX_ARRAY:
		items.remove_at(0)
	Events.arsenal_changed.emit()
