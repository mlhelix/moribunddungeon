extends Area2D
class_name DamageZone


#@onready var sprite_texture: Texture2D
var potion = load("res://Scripts/Global/Items/potion.tres") as Item_Usable
var playerinv = Inventory
var knockback_strength = 10.0


func _onready():
	#var newsprite = sprite_texture.load("res://assets/Items_Potion01.png") 
	pass
	

func _on_body_entered(body) -> void:
	if "Player" in body.name:
		body.take_damage(42)
		var direction = global_position.direction_to(body.global_position)
		var explosive_force = direction * knockback_strength
		body.knockback = explosive_force
		
		print("Inventory size: " + str(body.inventory.items.size()))
		print("OUCH! Add a potion!")
		body.add_item(potion)
		#
		#
		#sprite_texture.texture.load("res://assets/Items_Potion01.png")
		#potion.set_data("Potion", sprite_texture, true, 1)
		#PlayerStats.inventory.add_item(potion, 1)
		#print("goodjob")
		#mypot.texture.load("res://assets/Items_Potion01.png")
		
		
		#newpot.set("texture", "res://assets/Items_Potion01.png")
		
