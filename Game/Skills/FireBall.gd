extends SkillResource

func apply_effects(target: Array[Node], stat: StatsResource) -> void:
	var attack_effect := AttackEffect.new()
	attack_effect.amount = 100 * stat.magicattack
	attack_effect.effect(target, SkillResource.Damage.MAGIC)
