extends SkillResource

func apply_effects(target: Array[Node]) -> void:
	var block_effect := HealEffect.new()
	block_effect.amount = 6
	block_effect.effect(target)
