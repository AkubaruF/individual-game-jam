extends Node2D

func _ready():
	fan_out_children()
	# Ensure the node is inside a valid viewport
	var viewport = get_viewport()
	if viewport:
		var viewport_width = viewport.get_visible_rect().size.x
		
		# Flip if the node is on the left side of the screen
		if position.x > viewport_width / 2:
			scale.x *= -1  # Flip horizontally

func fan_out_children():
	var children_count = get_child_count()
	if children_count == 0:
		return
	
	var spacing = 100  # Adjust this value for more/less spacing
	var start_y = -((children_count - 1) * spacing) / 2  # Center the group
	
	for i in range(children_count):
		var child = get_child(i)
		if child is Node2D:
			child.position = Vector2(0, start_y + i * spacing)
