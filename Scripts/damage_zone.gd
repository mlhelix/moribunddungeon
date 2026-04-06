extends Area2D
class_name DamageZone


func _on_body_entered(body):
	if "Player" in body.name:
		body.take_damage(10)
