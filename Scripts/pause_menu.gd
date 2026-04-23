extends CanvasLayer

#@export var equip_menu: Stats_Menu
var equip_is_open = false
var bag_is_open = false
@onready var bag_visibility = $PanelContainer/VBoxContainer/Bag/InventoryUI
@onready var hud_pos = $"../../HUD"

func _ready():
	$".".visible = false
	$AnimationPlayer.play("RESET")

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	await $AnimationPlayer.animation_finished
	$".".visible = false
	bag_visibility.visible = false
	hud_pos.offset.x -= 518
	
func pause():
	$".".visible = true
	$"PanelContainer/VBoxContainer/Resume".grab_focus()
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	

func esc_pressed():
	$"PanelContainer/VBoxContainer/Equipment/PlayerStatsMenu".update_stats()
	if Input.is_action_just_pressed("esc") and get_tree().paused == false:
		$Currency/HBoxContainer/Number.text = str(GlobalManager.stats.currency)
		hud_pos.offset.x += 518
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused == true:
		#$AnimationPlayer.play_backwards("blur")
		if equip_is_open:
			#get_node("../Equipment/AnimationPlayer").play_backwards("fade_inout")
			equip_is_open = false
		if bag_visibility.visible:
			bag_visibility.visible = !bag_visibility.visible
		resume()

func _on_resume_pressed() -> void:
	resume()


func _on_settings_pressed() -> void:
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	$AnimationPlayer.play("RESET")
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")

func _process(_delta):
	if Input.is_action_just_pressed("esc"):
		esc_pressed()
	pass


func _on_equipment_pressed() -> void:
	equip_is_open = true
	var equipment_menu = $PanelContainer/VBoxContainer/Equipment/EquipmentUI
	equipment_menu.visible = !equipment_menu.visible
	equipment_menu._grab_focus()
	#$PanelContainer/VBoxContainer/Equipment/PlayerInventoryGUI/AnimationPlayer.play("fade_inout")
	#get_node("$PanelContainer/VBoxContainer/Equipment/PlayerStatsMenu")
	#$"../Equipment".update_stats()
	#get_node("../Equipment/AnimationPlayer").play("fade_inout")
	

func _on_equipment_focus_exited() -> void:
	if equip_is_open:
		#$PanelContainer/VBoxContainer/Equipment/PlayerInventoryGUI/AnimationPlayer.play_backwards("fade_inout")
		#get_node("../Equipment/AnimationPlayer").play_backwards("fade_inout")
		equip_is_open = false


func _on_bag_pressed() -> void:
	bag_visibility.visible = !bag_visibility.visible
	$PanelContainer/VBoxContainer/Bag/InventoryUI/Inventory_UI._grab_focus()
	pass # Replace with function body.
