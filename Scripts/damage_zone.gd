extends Area2D
class_name DamageZone


var knockback_strength = 10.0

func _on_body_entered(body):
	if "Player" in body.name:
		body.take_damage(5)
		var direction = global_position.direction_to(body.global_position)
		var explosive_force = direction * knockback_strength
		body.knockback = explosive_force
		
