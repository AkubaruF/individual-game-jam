extends AnimatedSprite2D

@export var characterStat: CharacterStat
@onready var StatUI: Control = $StatUI

func _ready() -> void:
	sprite_frames = characterStat.sprite
	play("idle")
	StatUI.set_position(Vector2(-256, -125))
