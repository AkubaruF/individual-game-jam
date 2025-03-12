extends CharacterBody2D

@onready var animated = $AnimatedSprite2D  # Get reference to AnimatedSprite2D

func _ready() -> void:
	animated.play("idle")
