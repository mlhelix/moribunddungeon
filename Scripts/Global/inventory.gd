extends Resource
class_name Inventory

@export var items: Array[Item]

func add_item(item: Item):
	items.append(item)
