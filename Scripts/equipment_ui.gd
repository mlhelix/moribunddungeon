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
		var slot = GlobalManager.equipment_slot_scene.instantiate()
		if item == "Necklace":
			necklace_container.add_child(slot)
		elif item == "Bracelet L" or "Bracelet R":
			brace_container.add_child(slot)
		elif item == "Ring 1" or "Ring 2":
			ring_container.add_child(slot)
		if GlobalManager[item] != null:
			slot.set_item(GlobalManager[item])
		else:
			slot.set_empty()
		#if count == 0:
			#var slot = GlobalManager.equipment_slot_scene.instantiate()
			#slot.set_slot_type("Necklace")
			#GlobalManager.equipment["Necklace"] = slot
			#necklace_container.add_child(slot)
			#_if_item(slot, GlobalManager.equipment[str(item)])
		#elif count == 1 or count == 2:
			#var slot = GlobalManager.equipment_slot_scene.instantiate()
			#slot.set_slot_type("Bracelet")
			#GlobalManager.equipment["Bracelet"] = slot
			#brace_container.add_child(slot)
			#_if_item(slot, item)
		#elif count == 3 or count == 4: 
			#var slot = GlobalManager.equipment_slot_scene.instantiate()
			#slot.set_slot_type("Ring")
			#GlobalManager.equipment["Ring"] = slot
			#ring_container.add_child(slot)
			#_if_item(slot, item)
		count += 1

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
