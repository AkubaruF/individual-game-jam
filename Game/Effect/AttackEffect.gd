class_name AttackEffect
extends skill_effect

var amount := 5

func effect(targets: Array[Node]) -> void:
	for target in targets:
		if not target:
			pass
		if target is Player or target is Enemy:
			target.take_damage(amount * -1)
