extends CanvasLayer

#@export var equip_menu: Stats_Menu
var bag_is_open = false
@onready var bag_visibility = $PanelContainer/VBoxContainer/Bag/InventoryUI
@onready var hud_pos = $"../../HUD"
@onready var equipment_menu = $PanelContainer/VBoxContainer/Equipment/EquipmentUI
@onready var equipment_button = $PanelContainer/VBoxContainer/Equipment
@onready var bag_button = $PanelContainer/VBoxContainer/Bag

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
	equipment_menu.visible = false
	
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
		if equipment_menu.visible:
			equip_visibility()
		if bag_visibility.visible:
			bag_visibility.visible = !bag_visibility.visible
		if equipment_menu.visible:
			equipment_menu.visible = false
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
	equip_visibility()
	

func _on_equipment_focus_exited() -> void:

	pass


func _on_bag_pressed() -> void:
	bag_visibility.visible = !bag_visibility.visible
	$PanelContainer/VBoxContainer/Bag/InventoryUI/Inventory_UI._grab_focus()
	pass # Replace with function body.

func equip_visibility():
	if !equipment_menu.visible:
		equipment_menu.visible = !equipment_menu.visible
		equipment_menu._grab_focus()
	elif equipment_menu.visible:
		equipment_menu.visible = !equipment_menu.visible
		equipment_button.grab_focus()
		
func _bag_visibility():
	if bag_visibility.visible:
		bag_visibility.visible = !bag_visibility.visible
		$PanelContainer/VBoxContainer/Bag.grab_focus()
	elif !bag_visibility.visible:
		bag_visibility.visible = !bag_visibility.visible
		$PanelContainer/VBoxContainer/Bag/InventoryUI/Inventory_UI._grab_focus()
