extends Control

#@onready var inventory: ShopInventory = preload("res://Scripts/Global/shop_00_inventory.tres")
@onready var vbox_container = $ShopItems/VBoxContainer


func _ready():
	GlobalManager.shop_inventory_updated.connect(_on_shop_inventory_updated)
	_on_shop_inventory_updated()

func _on_shop_inventory_updated():
	clear_container()
	for item in GlobalManager.shop_00_inventory:
		var slot = GlobalManager.shop_slot_scene.instantiate()
		vbox_container.add_child(slot)
		if item != null:
			slot.set_item(item)
		else:
			slot.set_empty()
	
func clear_container():
	while vbox_container.get_child_count() > 0:
		var child = vbox_container.get_child(0)
		vbox_container.remove_child(child)
		child.queue_free()

func _grab_focus():
	vbox_container.get_child(0).get_node("ItemButton").grab_focus()
	#grid_container.get_child(0)
	pass


func _on_exit_shop_button_pressed() -> void:
	get_tree().paused = false
	$"..".visible = false
	pass # Replace with function body.
