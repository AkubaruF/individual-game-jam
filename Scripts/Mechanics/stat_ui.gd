class_name StatUI
extends Control

@onready var hpvalue: Label = $VBoxContainer/HBoxContainer/hpvalue
@onready var hpbar: ProgressBar = $VBoxContainer/hpbar
@onready var attackvalue: Label = $VBoxContainer/HBoxContainer2/attackvalue
@onready var mattackvalue: Label = $VBoxContainer/HBoxContainer3/mattackvalue
@onready var defensevalue: Label = $VBoxContainer/HBoxContainer4/defensevalue
@onready var mdefensevalue: Label = $VBoxContainer/HBoxContainer5/mdefensevalue
@onready var speedvalue: Label = $VBoxContainer/HBoxContainer6/speedvalue

func update_stats(stats: StatsResource) -> void:
	hpvalue.text = str(stats.health) + "/" + str(stats.maxhealth)
	hpbar.value = stats.health
	hpbar.max_value = stats.maxhealth
	attackvalue.text = str(stats.attack) 
	mattackvalue.text = str(stats.magicattack) 
	defensevalue.text = str(stats.defense) 
	mdefensevalue.text = str(stats.magicdefense) 
	speedvalue.text = str(stats.speed) 
