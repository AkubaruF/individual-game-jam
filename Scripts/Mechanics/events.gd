extends Node

signal skill_played(skill:SkillResource)
signal next_attack()
signal arsenal_changed()
signal enemy_died()

signal shop_exited()
signal skill_buy(skill: SkillResource, cost: int)
signal stat_buy(amount: int, type: String, cost: int)

var gold_run = 6
