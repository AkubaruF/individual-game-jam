extends SkillResource

func apply_effects(target: Array[Node], stat: StatsResource) -> void:
	var block_effect := HealEffect.new()
	block_effect.amount = 2
	block_effect.effect(target, SkillResource.Damage.MAGIC)
