extends Control
	
func _ready():
	#$AnimationPlayer.play("RESET")
	pass
	
func _on_start_button_pressed() -> void:
	#get_tree().change_scene_to_file()
	pass # Replace with function body.

func _on_arena_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/testarena.tscn")
	pass # Replace with function body.

func _on_exit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/options.tscn")
	pass # Replace with function body.


func _on_start_game_focus_entered() -> void:
	$AnimationPlayer.play("startgame_anim")
	pass # Replace with function body.


func _on_options_focus_entered() -> void:
	$AnimationPlayer.play("startgame_anim")
	pass # Replace with function body.
