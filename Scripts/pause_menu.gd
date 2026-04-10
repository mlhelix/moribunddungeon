extends Control

@export var equip_menu: Stats_Menu
var equip_is_open = false

func _ready():
	$".".visible = false
	$AnimationPlayer.play("RESET")

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	await $AnimationPlayer.animation_finished
	$".".visible = false
	
func pause():
	$".".visible = true
	$"PanelContainer/VBoxContainer/Resume".grab_focus()
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	

func esc_pressed():
	if Input.is_action_just_pressed("esc") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused == true:
		#$AnimationPlayer.play_backwards("blur")
		if equip_is_open:
			get_node("../Equipment/AnimationPlayer").play_backwards("fade_inout")
			equip_is_open = false
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
	equip_is_open = true
	$"../Equipment".update_stats()
	get_node("../Equipment/AnimationPlayer").play("fade_inout")
	

func _on_equipment_focus_exited() -> void:
	if equip_is_open:
		get_node("../Equipment/AnimationPlayer").play_backwards("fade_inout")
		equip_is_open = false
