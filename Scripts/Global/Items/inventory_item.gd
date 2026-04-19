
@tool
extends Node2D

@export var item_type = ""
@export var item_name = ""
@export var item_texture = Texture
@export var item_effect = ""
#@export var item_quantity = 1
var scene_path: String = "res://Scenes/inventory_item.tscn"

@onready var icon_sprite = $Sprite2D

var player_in_range = false

func _ready():
	if not Engine.is_editor_hint():
		icon_sprite.texture = item_texture


func _process(_delta):
	if not Engine.is_editor_hint():
		icon_sprite.texture = item_texture
		
	if player_in_range and Input.is_action_just_pressed("ui_add"):
		pickup_item()
		
#func _physics_process(delta: float) -> void:
	#if not is_on_floor():
	#velocity += get_gravity() * delta

func pickup_item():
	var item = {
		"quantity" : 1,
		"item_type" : item_type,
		"item_name" : item_name,
		"item_texture" : item_texture,
		"item_effect" : item_effect,
		"scene_path" : scene_path
	}
	if GlobalManager.player_node:
		GlobalManager.add_item(item)
		self.queue_free()
		
func set_item_data(data):
	item_type = data["item_type"]
	item_name = data["item_name"]
	item_texture = data["item_texture"]
	item_effect = data["item_effect"]
	scene_path = data["scene_path"]
#	item_quantity = data["quantity"]

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		player_in_range = true
		body.ui_interact.visible = true


func _on_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		player_in_range = false
		body.ui_interact.visible = false
