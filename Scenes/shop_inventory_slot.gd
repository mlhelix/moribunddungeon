extends Control

@onready var item_icon = $Button/HBoxContainer/Icon/ItemIcon
@onready var item_name = $Button/HBoxContainer/ItemName
@onready var item_price = $Button/HBoxContainer/ItemPrice
@onready var item_type: String = ""
@onready var item_quantity: int = 0
@onready var item_effect: String = ""
@onready var quantity_label: String = ""
var slot_item = null

func set_empty():
	item_icon.texture = null
	quantity_label = ""

func set_item(new_item):
	slot_item = new_item
	item_icon.texture = new_item["item_texture"]
	item_quantity = slot_item["quantity"]
	item_name.text = str(slot_item["item_name"])
	item_type = str(slot_item["item_type"])
	item_price.text = str(slot_item["item_price"])
	if slot_item["item_effect"] != "":
		item_effect = str(" ", slot_item["item_effect"])
	else:
		item_effect = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	pass # Replace with function body.
