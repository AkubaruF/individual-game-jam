class_name BannerStatUI
extends Control

@onready var namevalue: RichTextLabel = $namevalue

func update_stats(stats: StatsResource) -> void:
	namevalue.text = str(stats.name)
