extends Control

@onready var necklace_container = $NinePatchRect/EquipType/NecklaceRow/EquipSlot
@onready var brace_container = $NinePatchRect/EquipType/BraceleteRow/EquipSlot
@onready var ring_container = $NinePatchRect/EquipType/RingRow/EquipSlot

func _ready():
	GlobalManager.equipment_updated.connect(_on_equipment_updated)
	GlobalManager.gameover.connect(_gameover)
	_on_equipment_updated()

func _on_equipment_updated():
	clear_grid_container()
	for item in GlobalManager.equipment:
		var slot = GlobalManager.equipment_slot_scene.instantiate()
		if item == "Necklace":
			necklace_container.add_child(slot)
		elif item == "Ring 1" or item == "Ring 2":
			ring_container.add_child(slot)
		elif item == "Bracelet L" or item == "Bracelet R":
			brace_container.add_child(slot)
		if GlobalManager.equipment[item] != null:
			slot.set_item(GlobalManager.equipment[item])
		else:
			slot.set_empty()

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
	
func _gameover():
	for item in GlobalManager.equipment:
		var slot = GlobalManager.equipment_slot_scene.instantiate()
		if item == "Necklace":
			necklace_container.add_child(slot)
		elif item == "Ring 1" or item == "Ring 2":
			ring_container.add_child(slot)
		elif item == "Bracelet L" or item == "Bracelet R":
			brace_container.add_child(slot)
		slot.set_empty()
	for item in GlobalManager.equipment:
		GlobalManager.equipment[item] = null
	#for item in GlobalManager.equipment:
		#GlobalManager.unequip_(GlobalManager.equipment[item])
	#GlobalManager.equipment_updated.emit()


func _on_button_pressed() -> void:
	$"../../../..".equip_visibility()
