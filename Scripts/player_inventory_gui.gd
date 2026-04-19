extends Control

@onready var inventory: Inventory = preload("res://Scripts/Global/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

func _ready():
	update()
	pass

func update():
	for i in range(min(inventory.items.size(), slots.size())):
		slots[i].update(inventory.items[i])
		


func _on_bag_pressed() -> void:
	update() # Replace with function body.
