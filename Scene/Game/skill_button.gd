extends TextureButton

@export var text : String = "String" 
var level:Node

func _ready():
	level = get_tree().root.get_child(0)
	setup_text()
	hide_arrows()
	focus_mode = Control.FOCUS_ALL

func _on_pressed() -> void:
	var enemyteam:Node2D = level.find_child("EnemyTeam", true, false)
	print(enemyteam.get_children())

func setup_text():
	$RichTextLabel.text = "[center]" + text + "[/center]"
	
func show_arrows():
	$Selected.visible = true

func hide_arrows():
	$Selected.visible = false

func _on_focus_entered() -> void:
	show_arrows()

func _on_focus_exited() -> void:
	hide_arrows()

func _on_mouse_entered() -> void:
	grab_focus()
