extends Control

@onready var icon = $InnerBorder/ItemIcon
@onready var quantity_label = $InnerBorder/ItemQuantity
@onready var details_panel = $"Detail Panel"
@onready var item_name = $"Detail Panel/ItemName"
@onready var item_type = $"Detail Panel/ItemType"
@onready var item_effect = $"Detail Panel/ItemEffect"
@onready var usage_panel = $UsagePanel
@onready var usage_panel_use = $UsagePanel/UseButton
@onready var equip_panel = $EquipPanel
@onready var equip_panel_use = $EquipPanel/EquipButton
@onready var item_button = $ItemButton
@onready var upper_window_ref = $"../../.."
var slot_item = null

func _on_item_button_pressed() -> void:
	if slot_item != null and item_type.text == "Useable":
		usage_panel.visible = !usage_panel.visible
		usage_panel_use.grab_focus()
	elif slot_item != null and "Equipment:" in item_type.text:
		equip_panel.visible = !equip_panel.visible
		equip_panel_use.grab_focus()

func _on_item_button_mouse_entered() -> void:
	if slot_item != null:
		usage_panel.visible = false
		details_panel.visible = true
		item_button.grab_focus()
	
func _on_item_button_mouse_exited() -> void:
	details_panel.visible = false

func _on_item_button_focus_entered() -> void:
	if slot_item != null:
		usage_panel.visible = false
		details_panel.visible = true

func _on_item_button_focus_exited() -> void:
	details_panel.visible = false
	
func set_empty():
	icon.texture = null
	quantity_label.text = ""
	
func set_item(new_item):
	slot_item = new_item
	icon.texture = slot_item["item_texture"]
	quantity_label.text = str(slot_item["quantity"])
	item_name.text = str(slot_item["item_name"])
	item_type.text = str(slot_item["item_type"])
	if slot_item["item_effect"] != "":
		item_effect.text = str(" ", slot_item["item_effect"])
	else:
		item_effect.text = ""
		
func _on_drop_button_pressed() -> void:
	if slot_item != null:
		var drop_pos = GlobalManager.player_node.global_position
		GlobalManager.drop_item(slot_item, drop_pos)
		GlobalManager.remove_item(slot_item["item_type"], slot_item["item_effect"])
		
func _on_use_button_pressed() -> void:
	if slot_item != null and slot_item["item_effect"] != "":
		if GlobalManager.player_node:
			GlobalManager.player_node.apply_item_effect(slot_item)
			GlobalManager.remove_item(slot_item["item_type"], slot_item["item_effect"])

func _on_equip_button_pressed() -> void:
	if slot_item != null and "Equipment:" in slot_item["item_type"]:
		GlobalManager.equip_(slot_item)
		upper_window_ref._grab_focus()
