extends Node2D

var player_stats: PlayerStats

func _ready():
	$ColorRect/Button.grab_focus()

func _on_button_pressed() -> void:
	GlobalManager.stats.health = 100
	GlobalManager.stats.current_health = 100
	SceneTransition.change_scene_to("res://Scenes/title_screen.tscn")
