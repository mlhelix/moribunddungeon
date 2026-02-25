extends Control

#func _process(delta):
	#if Input.is_key_pressed(KEY_ESCAPE):
		#get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")
	#pass

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")
	pass # Replace with function body.
