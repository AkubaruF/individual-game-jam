extends StatsResource
class_name CharacterStat

@export var starting_arsenal: Arsenal
var arsenal: Arsenal

func create_instance() -> Resource:
	var instance: CharacterStat = self.duplicate()
	instance.health = maxhealth
	instance.arsenal = instance.starting_arsenal.duplicate()
	return instance
