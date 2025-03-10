extends CharacterBody2D

@onready var animated = $AnimatedSprite2D  # Get reference to AnimatedSprite2D

func _process(delta):
	if Input.is_action_pressed("ui_up"):
		animated.play("idle")
	if Input.is_action_pressed("ui_right"):
		animated.play("attack1")
	if Input.is_action_pressed("ui_left"):
		animated.play("attack2")
