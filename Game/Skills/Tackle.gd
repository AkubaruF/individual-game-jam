extends SkillResource

func apply_effects(target: Array[Node]) -> void:
	var attack_effect := AttackEffect.new()
	attack_effect.amount = 3
	attack_effect.effect(target)
