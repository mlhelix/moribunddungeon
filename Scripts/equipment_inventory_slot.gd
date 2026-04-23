extends Control

@onready var icon = $InnerBorder/ItemIcon
@onready var quantity_label = $InnerBorder/ItemQuantity
@onready var details_panel = $"Detail Panel"
@onready var item_name = $"Detail Panel/ItemName"
@onready var item_type = $"Detail Panel/ItemType"
@onready var item_effect = $"Detail Panel/ItemEffect"
@onready var unequip_panel = $UnequipPanel
@onready var unequip_panel_use = $UnequipPanel/UnequipButton
@onready var item_button = $ItemButton
@onready var slot_type = ""
var slot_item = null

func _on_item_button_pressed() -> void:
	if slot_item != null and "Equipment:" in item_type.text:
		unequip_panel.visible = !unequip_panel.visible
		unequip_panel_use.grab_focus()

func _on_item_button_mouse_entered() -> void:
	if slot_item != null:
		unequip_panel.visible = false
		details_panel.visible = true
		item_button.grab_focus()
	
func _on_item_button_mouse_exited() -> void:
	details_panel.visible = false

func _on_item_button_focus_entered() -> void:
	if slot_item != null:
		unequip_panel.visible = false
		details_panel.visible = true

func _on_item_button_focus_exited() -> void:
	details_panel.visible = false
	
func set_empty():
	icon.texture = null
	quantity_label.text = ""

func set_slot_type(new_type):
	slot_type = new_type
	
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
		
func _on_use_button_pressed() -> void:
	if slot_item != null and slot_item["item_effect"] != "":
		if GlobalManager.player_node:
			GlobalManager.player_node.apply_item_effect(slot_item)
			GlobalManager.remove_item(slot_item["item_type"], slot_item["item_effect"])

func _on_equip_button_pressed() -> void:
	if slot_item != null and "Equipment:" in slot_item["item_type"]:
		
		pass
	pass # Replace with function body.


func _on_cancel_button_pressed() -> void:
	pass # Replace with function body.


func _on_unequip_button_pressed() -> void:
	if slot_item != null:
		GlobalManager.unequip_(slot_item)
		slot_item = null
