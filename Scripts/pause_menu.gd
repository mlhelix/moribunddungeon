extends Control

@export var equip_menu: Stats_Menu

func _ready():
	$".".visible = false
	$AnimationPlayer.play("RESET")

func resume():
	$".".visible = false
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")

func pause():
	$".".visible = true
	$"PanelContainer/VBoxContainer/Resume".grab_focus()
	get_tree().paused = true
	$AnimationPlayer.play("blur")

func esc_pressed():
	if Input.is_action_just_pressed("esc") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused == true:
		resume()

func _on_resume_pressed() -> void:
	resume()


func _on_settings_pressed() -> void:
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	$AnimationPlayer.play("RESET")
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")

func _process(delta):
	esc_pressed()


func _on_equipment_pressed() -> void:
	$"../Equipment".update_stats()
	get_node("../Equipment/AnimationPlayer").play("fade_inout")
	

func _on_equipment_focus_exited() -> void:
	get_node("../Equipment/AnimationPlayer").play_backwards("fade_inout")
