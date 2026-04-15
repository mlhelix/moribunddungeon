extends Resource
class_name Inventory

@export var items: Array[Item]
var banana: Item_Usable
var lemon: Item

func _ready():
	#set_inv_size()
	pass

func add_item(item: Item):
	if banana is Item:
		print("Banana is an item usable ITEM")
	if lemon is Item:
		print("Banana is an item usable ITEM")
	print(lemon)
	for i in items:
		#if i == null:
			#items[i] = item
			##items[i].set("Sprite", item.sprite)
			#print("Item name is:")
			#print(items[i].get("Item Name"))
			#items[i] = items
			break
	#pass
	
func set_inv_size():
	#items.resize(6)
	pass
