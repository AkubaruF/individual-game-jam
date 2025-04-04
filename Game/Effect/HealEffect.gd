class_name HealEffect
extends skill_effect

var amount := 5

func effect(targets: Array[Node], type: SkillResource.Damage) -> void:
	for target in targets:
		if not target:
			pass
		if target is Player:
			target.heal_damage(amount, type)
		if target is Enemy:
			target.heal_damage(amount, type)
