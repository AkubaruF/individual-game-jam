class_name Enemy
extends AnimatedSprite2D

@export var statsResource: StatsResource: set = set_enemy_stats
@onready var StatUI: Control = $StatUI as StatUI
@onready var BannerStatUI: Control = $EnemyBanner as BannerStatUI

func set_enemy_stats(value: StatsResource) -> void:
	statsResource = value.create_instance()
	
	if not statsResource.stats_changed.is_connected(update_stats):
		statsResource.stats_changed.connect(update_stats)
	
	update_enemy()
	
func update_enemy() -> void:
	if not statsResource is StatsResource:
		return
	if not is_inside_tree():
		await ready
	
	sprite_frames = statsResource.sprite
	play("idle")
	StatUI.set_position(Vector2(75, -125))
	BannerStatUI.set_position(Vector2(183, -233))
	
	update_stats()
	
func update_stats() -> void:
	StatUI.update_stats(statsResource)
	BannerStatUI.update_stats(statsResource)

func take_damage(damage: int, type: SkillResource.Damage) -> void:
	if statsResource.health <= 0:
		return
	statsResource.damage(damage, type)
	
	$AnimatedSprite2D.visible = true
	$AnimatedSprite2D.play("damage")
	#await $AnimatedSprite2D.animation_finished
	#$AnimatedSprite2D.visible = false
	
	if statsResource.health <= 0:
		if is_inside_tree():
			var tree := get_tree()
			visible = false
			await tree.create_timer(0.1).timeout
			visible = true
			await tree.create_timer(0.1).timeout
			visible = false
			await tree.create_timer(0.1).timeout
			visible = true
			await tree.create_timer(0.1).timeout
			visible = false
			statsResource.randomize_stats_with_bonus()
			statsResource.health = statsResource.maxhealth
			await tree.create_timer(0.1).timeout
			visible = true
			Events.enemy_died.emit()
		else:
			visible = false
			visible = true
			visible = false
			visible = true
			visible = false
			statsResource.randomize_stats_with_bonus()
			statsResource.health = statsResource.maxhealth
			visible = true
			Events.enemy_died.emit()

func heal_damage(damage: int, type: SkillResource.Damage) -> void:
	if statsResource.health <= 0:
		return
	statsResource.heal(damage, type)
	
	$AnimatedSprite2D.visible = true
	$AnimatedSprite2D.play("heal")
	#await $AnimatedSprite2D.animation_finished
	#$AnimatedSprite2D.visible = false
	
	if statsResource.health <= 0:
		queue_free()
