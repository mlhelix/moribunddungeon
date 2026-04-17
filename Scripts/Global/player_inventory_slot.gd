extends Control

@onready var item = $InnerBorder/ItemIcon
@onready var quantity = $InnerBorder/ItemQuantity
@onready var details_panel = $"Detail Panel"
@onready var item_name = $"Detail Panel/ItemName"
@onready var item_type = $"Detail Panel/ItemType"
@onready var item_effect = $"Detail Panel/ItemEffect"
@onready var usage_panel = $UsagePanel

var slot_item = null


func _on_item_button_pressed() -> void:
	if item != null:
		usage_panel.visible = !usage_panel.visible


func _on_item_button_mouse_entered() -> void:
	if item != null:
		usage_panel.visible = false
		details_panel.visible = true
	pass
	
func _on_item_button_mouse_exited() -> void:
	details_panel.visible = false

func set_empty():
	item.texture = null
	quantity.label.text = ""
	
func set_item(new_item):
	item = new_item
	item.texture = new_item["texture"]
	quantity.label.text = str(item["quantity"])
	item_name.text = str(item["name"])
	item_type.text = str(item["type"])
	if item["effect"] != "":
		item_effect.text = str("- ", item["effect"])
	else:
		item_effect.text = ""
		
#@onready var itemSprite: Sprite2D = $CenterContainer/Panel/Item
#
#func _ready() -> void:
	#grab_focus()
#
#func update(item: Item):
	#if !item:
		#itemSprite.visible = false
	#else:
		#itemSprite.visible = true
		#itemSprite.texture = item.sprite
		#var scaling = Vector2(($".".size.x / itemSprite.texture.get_width()) - 0.02, ($".".size.y / itemSprite.texture.get_height()) - 0.02)
		#itemSprite.apply_scale(Vector2(scaling))
		#print("Updated")
	
