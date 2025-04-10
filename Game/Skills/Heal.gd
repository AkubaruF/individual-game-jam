extends SkillResource

func apply_effects(target: Array[Node], stat: StatsResource) -> void:
	var heal_effect := HealEffect.new()
	heal_effect.amount = stat.magicattack / 5
	heal_effect.effect(target, SkillResource.Damage.PHYSICAL)
