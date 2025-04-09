extends SkillResource

func apply_effects(target: Array[Node], stat: StatsResource) -> void:
	var attack_effect := AttackEffect.new()
	attack_effect.amount = 50 * stat.defense
	attack_effect.effect(target, SkillResource.Damage.PHYSICAL)
