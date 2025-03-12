extends AnimatedSprite2D

@export var characterStat: CharacterStat: set = set_character_stats
@onready var StatUI: Control = $StatUI as StatUI
@onready var BannerStatUI: Control = $PlayerBanner as BannerStatUI

func set_character_stats(value: CharacterStat) -> void:
	characterStat = value.create_instance()
	
	if not characterStat.stats_changed.is_connected(update_stats):
		characterStat.stats_changed.connect(update_stats)
	
	update_player()
	
func update_player() -> void:
	if not characterStat is CharacterStat:
		return
	if not is_inside_tree():
		await ready
	
	sprite_frames = characterStat.sprite
	play("idle")
	StatUI.set_position(Vector2(-256, -125))
	BannerStatUI.set_position(Vector2(-183, -233))
	
	update_stats()
	
func update_stats() -> void:
	StatUI.update_stats(characterStat)
	BannerStatUI.update_stats(characterStat)

func take_damage(damage: int) -> void:
	if characterStat.health <= 0:
		return
	characterStat.health_change(damage * -1)
	if characterStat.health <= 0:
		queue_free()
