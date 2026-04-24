extends Control
	
	
func _ready():
	$"Start Game".grab_focus()

func _on_arena_pressed() -> void:	
	#get_tree().change_scene_to_file("res://Scenes/testarena.tscn")
	SceneTransition.change_scene_to("res://Scenes/testarena.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_options_pressed() -> void:
	#get_tree().change_scene_to_file("res://Scenes/options.tscn")
	pass


func _on_start_game_focus_entered() -> void:
	$AnimationPlayer.play("startgame_anim")


func _on_options_focus_entered() -> void:
	$AnimationPlayer.play("startgame_anim")


func _on_start_game_pressed() -> void:
	SceneTransition.change_scene_to("res://Scenes/testarena2.tscn")


func _on_arena_focus_entered() -> void:
	$AnimationPlayer.play("startgame_anim")
