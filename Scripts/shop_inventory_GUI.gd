extends Control

@onready var inventory: ShopInventory = preload("res://Scripts/Global/shop_00_inventory.tres")
@onready var slots: Array = $CanvasLayer/ShopItems.get_children()

func _ready():
	update()
	pass

func update():
	for i in range(min(inventory.items.size(), slots.size())):
		slots[i].update(inventory.items[i])
		


func _on_tab_pressed() -> void:
	update() # Replace with function body.
