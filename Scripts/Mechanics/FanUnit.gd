extends Node2D

func _ready():
	# Ensure the node is inside a valid viewport
	var viewport = get_viewport()
	if viewport:
		var viewport_width = viewport.get_visible_rect().size.x
		
		# Flip if the node is on the left side of the screen
		if position.x > viewport_width / 2:
			scale.x *= -1  # Flip horizontally
