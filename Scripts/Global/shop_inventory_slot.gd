extends Control

@onready var item_icon = $Button/HBoxContainer/Icon/ItemIcon
@onready var item_name = $Button/HBoxContainer/ItemName
@onready var item_price = $Button/HBoxContainer/ItemPrice
@onready var item_type: String = ""
@onready var item_quantity: int = 0
@onready var item_effect: String = ""
@onready var quantity_label: String = ""
@onready var shop_position: int = 0
var slot_item = null
@export var player_stats: PlayerStats

func set_empty():
	item_icon.texture = null
	quantity_label = ""

func set_item(new_item):
	slot_item = new_item
	item_icon.texture = slot_item["item_texture"]
	item_icon.scale = Vector2(36.0/item_icon.texture.get_width(), 36.0/item_icon.texture.get_height())
	item_quantity = slot_item["quantity"]
	item_name.text = str(slot_item["item_name"])
	item_type = str(slot_item["item_type"])
	item_price.text = str(slot_item["item_price"], " G")
	if slot_item["item_effect"] != "":
		item_effect = str(" ", slot_item["item_effect"])
	else:
		item_effect = ""
	shop_position = slot_item["shop_position"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	$PurchasePanel.visible = !$PurchasePanel.visible
	$"Button".focus_mode = FOCUS_NONE
	for each in $"..".get_children():
		each.get_node("Button").focus_mode = FOCUS_NONE
	$PurchasePanel/PurchaseButton.grab_focus()

func _on_purchase_button_pressed() -> void:
	var full_buttons = $".."
	if player_stats.currency >= int(item_price.text) and slot_item != null:
		player_stats._change_currency(-int(item_price.text))
		$"../../../Currency/HBoxContainer/Number".text = str(player_stats.currency)
		#GlobalManager.player.change_currency(-int(item_price.text))
		$PurchasePanel.visible = !$PurchasePanel.visible
		GlobalManager.add_item(slot_item)
		GlobalManager.remove_shop_item(shop_position, GlobalManager.shop_00_inventory)
		for each in full_buttons.get_children():
			each.get_node("Button").focus_mode = FOCUS_ALL
		#full_buttons.get_children()[0].get_node("Button").grab_focus()
		if full_buttons.get_child(0) != null:
			full_buttons.get_child(0).get_node("Button").grab_focus()
	else:
		$PurchasePanel.visible = !$PurchasePanel.visible
		pass

func _on_cancel_button_pressed() -> void:
	$PurchasePanel.visible = !$PurchasePanel.visible
	$Button.focus_mode = FOCUS_ALL
	$Button.grab_focus()
	for each in $"..".get_children():
		each.get_node("Button").focus_mode = FOCUS_ALL
	


#func _on_purchase_button_gui_input(event: InputEvent) -> void:
	#if event.is_action_pressed("ui_up"):
		#$PurchasePanel.visible = !$PurchasePanel.visible
		#$Button.grab_focus()
	#pass # Replace with function body.
