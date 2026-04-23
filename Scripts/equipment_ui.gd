extends Control

@onready var necklace_container = $NinePatchRect/EquipType/NecklaceRow/EquipSlot
@onready var brace_container = $NinePatchRect/EquipType/BraceleteRow/EquipSlot
@onready var ring_container = $NinePatchRect/EquipType/RingRow/EquipSlot

func _ready():
	GlobalManager.inventory_updated.connect(_on_inventory_updated)
	_on_inventory_updated()

func _on_inventory_updated():
	clear_grid_container()
	var count = 0
	for item in GlobalManager.equipment:
		if count == 0:
			var slot = GlobalManager.equipment_slot_scene.instantiate()
			slot.get_node("EquipmentSlot")
			necklace_container.add_child(slot)
			_if_item(slot, item)
		elif count == 1 or count == 2:
			var slot = GlobalManager.equipment_slot_scene.instantiate()
			brace_container.add_child(slot)
			_if_item(slot, item)
		elif count == 3 or count == 4: 
			var slot = GlobalManager.equipment_slot_scene.instantiate()
			ring_container.add_child(slot)
			_if_item(slot, item)

func _if_item(slot, item):
	if item != null:
		slot.set_item(item)
	else:
		slot.set_empty()

func clear_grid_container():
	while necklace_container.get_child_count() > 0:
		var child = necklace_container.get_child(0)
		necklace_container.remove_child(child)
		child.queue_free()
	while brace_container.get_child_count() > 0:
		var child = brace_container.get_child(0)
		brace_container.remove_child(child)
		child.queue_free()
	while ring_container.get_child_count() > 0:
		var child = ring_container.get_child(0)
		ring_container.remove_child(child)
		child.queue_free()

func _grab_focus():
	$NinePatchRect/EquipType/Button.grab_focus()
	#equip_container.get_child(0).get_node("ItemButton").grab_focus()
	#grid_container.get_child(0)
