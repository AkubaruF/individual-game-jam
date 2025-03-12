extends AnimatedSprite2D

@export var statsResource: StatsResource
@onready var StatUI: Control = $StatUI

func _ready() -> void:
	sprite_frames = statsResource.sprite
	play("idle")
	StatUI.set_position(Vector2(-75, -125))
