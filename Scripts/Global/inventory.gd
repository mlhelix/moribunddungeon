extends Resource
class_name Inventory

@export var items: Array[Item]

func add_item(item: Item):
	for i in items:
		if !Item:
			items[i].set("Item Name", item.item_name)
			items[i].set("Sprite", item.sprite)
			#items[i] = items
			break
	
