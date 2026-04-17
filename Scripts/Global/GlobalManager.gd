extends Node

signal inventory_updated

var stats = preload("res://Scripts/Global/player_stats.tres")
#var potion = preload("res://Scripts/Global/Items/potion.tres")
var inventory = []

var player_node: Node = null
@onready var inventory_slot_scene = preload("res://Scenes/player_inventory_slot.tscn")

func _ready():
	inventory.resize(9)
	
func add_item(item):
	for i in range(inventory.size()):
		if inventory[i] != null and inventory[i]["type"] == item["type"] and inventory[i]["effect"] == item["effect"]:
			inventory[i]["quantity"] += item["quantity"]
			inventory_updated.emit()
			return true
		elif inventory[i] == null:
			inventory[i] = item
			inventory_updated.emit()
			return true
		return false

	
func remove_item():
	inventory_updated.emit()
	
func increase_inventory_size():
	inventory_updated.emit()
	
func set_player_reference(player):
	player_node = player
	
