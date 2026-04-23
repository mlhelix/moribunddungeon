@tool
extends Node2D
class_name Equipment

# Exports ==================================
@export var item_name = ""
@export var item_type = "Equipment"
@export var item_effect = ""
@export var item_texture = Texture
@export var item_price = 0
@export var item_quantity = 1
# Stats ===
@export var max_health: int = 0
@export var max_sp: int = 0
@export var attack: int = 0
@export var defense: int = 0
@export var magic: int = 0
@export var magdef: int = 0
@export var resist: int = 0
@export var crit: int = 0
@export var descript: String = ""
# Scene Path ===============================
var scene_path: String = "res://Scenes/equipment_item.tscn"
# On Ready =================================
@onready var icon_sprite = $Sprite2D
@onready var rarity_anim = $Rarity
@onready var collision_area = $Area2D/CollisionShape2D
var player_in_range = false
var player_stats: PlayerStats # Player stats
var equip_stats = {}
#Add Special Modifier

func _init():
	pass
	
func _ready():
	equip_stats = {
		"item_name" : item_name,
		"item_type" : item_type,
		"item_effect" : descript,
		"item_texture" : item_texture,
		"quantity" : item_quantity,
		"health" : max_health,
		"stamina" : max_sp,
		"attack" : attack,
		"defense" : defense,
		"magic" : magic,
		"magdef" : magdef,
		"resist" : resist,
		"crit" : crit,
		"item_price" : item_price,
		"descript" : descript,
		"scene_path" : scene_path
	}

	if not Engine.is_editor_hint():
		icon_sprite.texture = item_texture
		icon_sprite.scale = Vector2(60.0/icon_sprite.texture.get_width(), 60.0/icon_sprite.texture.get_height())
		collision_area.scale = Vector2(50.0/collision_area.shape.get_rect().size.x, 50.0/collision_area.shape.get_rect().size.y)
	if rarity_anim.visible:
		rarity_anim.play("default")
		rarity_anim.scale = Vector2(65.0/icon_sprite.texture.get_width(), 65.0/icon_sprite.texture.get_height())
func _process(_delta):
	if not Engine.is_editor_hint():
		icon_sprite.texture = item_texture
		
	if player_in_range and Input.is_action_just_pressed("ui_add"):
		pickup_item()

func pickup_item():
	var item = _get_stats()
	rarity_anim.visible = false
	if GlobalManager.player_node:
		GlobalManager.add_item(item)
		self.queue_free()

func set_item_data(data):
	item_type = data["item_type"]
	item_name = data["item_name"]
	item_texture = data["item_texture"]
	item_effect = data["item_effect"]
	scene_path = data["scene_path"]
	item_quantity = data["quantity"]
	item_price = data["item_price"]
	max_health = data["health"]
	max_sp = data["stamina"]
	attack = data["attack"]
	defense = data["defense"]
	magic = data["magic"]
	magdef = data["magdef"]
	resist = data["resist"]
	crit = data["crit"]
	descript = data["descript"]
	equip_stats = _get_stats()
	
func _on_equip():
	pass
	
func _on_unequip():
	pass
	
func _additional_effects():
	#Not used yet
	pass
	
func _get_stats():
	return equip_stats
	
func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		player_in_range = true
		body.ui_interact.visible = true
		body._ui_interact("Press \"E\" to pick up")

func _on_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		player_in_range = false
		body.ui_interact.visible = false
