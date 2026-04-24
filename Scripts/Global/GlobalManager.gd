extends Node

signal inventory_updated
signal equipment_updated
signal shop_inventory_updated
signal gameover

var stats = preload("res://Scripts/Global/player_stats.tres")
var inventory = []
var equipment = {
	"Necklace" : null,
	"Bracelet L" : null,
	"Bracelet R" : null,
	"Ring 1" : null,
	"Ring 2" : null
}
#Main Hub Shop Inventory
var shop_00_inventory = []

#Items
var item_tex_loader: Texture = preload("res://assets/Items_Potion01.png")
var item_potion = {
		"quantity" : 1,
		"item_type" : "Useable",
		"item_name" : "Potion",
		"item_texture" : item_tex_loader,
		"item_effect" : "Heals 20 HP",
		"scene_path" : "res://Scenes/inventory_item.tscn",
		"item_price" : 100,
		"shop_position" : 0
	}

var player_node: Node = null
@onready var inventory_slot_scene = preload("res://Scenes/player_inventory_slot.tscn")
@onready var shop_slot_scene = preload("res://Scenes/shop_inventory_slot.tscn")
@onready var equipment_slot_scene = preload("res://Scenes/equipment_inventory_slot.tscn")

func _ready():
	inventory.resize(21)
	#equipment.resize(6)
	_init_shops()

func add_item(item):
	for i in range(inventory.size()):
		if inventory[i] != null and inventory[i]["item_type"] == item["item_type"] and inventory[i]["item_effect"] == item["item_effect"]:
			inventory[i]["quantity"] += item["quantity"]
			inventory_updated.emit()
			return true
		elif inventory[i] == null:
			inventory[i] = item
			inventory_updated.emit()
			return true
	return false


func remove_item(item_type, item_effect):
	for i in range(inventory.size()):
		if inventory[i] != null and inventory[i]["item_type"] == item_type and inventory[i]["item_effect"] == item_effect:
			inventory[i]["quantity"] -= 1
			if inventory[i]["quantity"] <= 0:
				inventory[i] = null
			inventory_updated.emit()
			return true
	return false
	
func equip_(item):
	if "Necklace" in item["item_type"]:
		if equipment["Necklace"] == null:
			equipment["Necklace"] = item
		else:
			add_item(equipment["Necklace"])
			equipment["Necklace"] = item
	elif "Bracelet" in item["item_type"]:
		#item._on_equip()
		if equipment["Bracelet L"] == null:
			equipment["Bracelet L"] = item
		elif equipment["Bracelet R"] == null:
			equipment["Bracelet R"] = item
		else:
			add_item(equipment["Bracelet L"])
			equipment["Bracelet L"] = item
	elif "Ring" in item["item_type"]:
		if equipment["Ring 1"] == null:
			equipment["Ring 1"] = item
		elif equipment["Ring 2"] == null:
			equipment["Ring 2"] = item
		else:
			add_item(equipment["Ring 1"])
			equipment["Ring 1"] = item
	remove_item(item["item_type"], item["item_effect"])
	stats._change_attack(item["attack"])
	stats._change_defense(item["defense"])
	stats._change_crit(item["crit"])
	stats._change_max_health(item["health"])
	equipment_updated.emit()
	
func unequip_(item):
	item["quantity"] += 1
	add_item(item)
	if "Necklace" in item["item_type"]:
		equipment["Necklace"] = null
	elif "Bracelet" in item["item_type"]:
		if item["item_name"] == equipment["Bracelet L"]:
			equipment["Bracelet L"] = null
		elif item["item_name"] == equipment["Bracelet R"]:
			equipment["Bracelet R"] = null
	elif "Ring" in item["item_type"]:
		if item["item_name"] == equipment["Ring 1"]:
			equipment["Ring 1"] = null
		elif item["item_name"] == equipment["Ring 2"]:
			equipment["Ring 2"] = null
	stats._change_attack(-item["attack"])
	stats._change_defense(-item["defense"])
	stats._change_crit(-item["crit"])
	stats._change_max_health(-item["health"])
	equipment_updated.emit()
	
func drop_item(item_data, drop_position):
	var item_scene = load(item_data["scene_path"])
	var item_instance = item_scene.instantiate()
	item_instance.set_item_data(item_data)
	item_instance["item_quantity"] = 1
	item_instance.global_position = drop_position
	get_tree().current_scene.add_child(item_instance)
	if "Equipment:" in item_instance["item_type"]:
		item_instance.get_node("Rarity").visible = true
		item_instance.get_node("Rarity").play("default")
	inventory_updated.emit()

func adjust_drop_position(position):
	return position

func increase_inventory_size(extra_slots):
	inventory.resize(inventory.size() + extra_slots)
	inventory_updated.emit()

func set_player_reference(player):
	player_node = player

func add_shop_item(item, shop_inv):
	for i in range(shop_inv.size()):
		if shop_inv[i] == null:
			shop_inv[i] = item
			shop_inventory_updated.emit()
			return true
		return false

func remove_shop_item(item_pos, shop_inv):
	if shop_inv[item_pos] != null:
		shop_inv.pop_at(item_pos)
		shop_inv.filter(func(item): return item != null)
		for i in range(shop_inv.size()):
			shop_inv[i]["shop_position"] = i
		shop_inventory_updated.emit()
		return true
	#for i in range(shop_inv.size()):
		#if shop_inv[i] != null and shop_inv[i]["item_type"] == item_type and shop_inv[i]["item_effect"] == item_effect:
			#shop_inv[i] = null
			#shop_inventory_updated.emit()
			#return true
	return false


func _init_shops():
	_init_shops_00(shop_00_inventory)

func _init_shops_00(shop_inv):
	shop_inv.resize(3)
	for each in shop_inv.size():
		item_potion["shop_position"] = each
		shop_inv[each] = item_potion
		shop_inventory_updated.emit()
		
func _gameover():
	_init_shops()
	SceneTransition.change_scene_to("res://Scenes/gameover.tscn")
	player_node.heal_damage(9999)
	gameover.emit()
