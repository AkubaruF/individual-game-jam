extends TextureButton

@export var skill : SkillResource
@export var stats : CharacterStat
var level:Node
var targets: Array[Node] = []

func _ready():
	level = get_tree().current_scene
	setup_text()
	hide_arrows()
	focus_mode = Control.FOCUS_ALL

func _on_pressed() -> void:
	if skill.target == SkillResource.Target.SELF:
		targets = [level.find_child("PlayerTeam", true, false).get_child(0)]
	elif skill.target == SkillResource.Target.ENEMY:
		targets = [level.find_child("EnemyTeam", true, false).get_child(0)]
	elif skill.target == SkillResource.Target.EVERYONE:
		targets = [level.find_child("PlayerTeam", true, false).get_child(0),level.find_child("EnemyTeam", true, false).get_child(0)]
	play()

func play() -> void:
	if not skill:
		return
	var player = level.find_child("PlayerTeam", true, false).get_child(0)
	if not (player is Player):
		return
	skill.play(targets, player.characterStat)

func setup_text():
	$RichTextLabel.text = "[center]" + skill.name + "[/center]"
	
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
