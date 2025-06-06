class_name AttackEffect
extends skill_effect

var amount := 5

func effect(targets: Array[Node], type: SkillResource.Damage) -> void:
	for target in targets:
		if not target:
			pass
		if target is Player:
			target.take_damage(amount, type)
		if target is Enemy:
			target.take_damage(amount, type)
