extends CharacterBody2D
class_name Cactynee

const MAX_HEALTH = 65
@export var health = MAX_HEALTH
@export var attack = 9
@onready var healthbar = $Healthbar


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()
	
	if velocity.length() > 0:
		$AnimationPlayer.play("walk")
		
	if velocity.x > 0:
		$Sprite2D.flip_h = false
	else:
		$Sprite2D.flip_h = true

func _ready():
	_update_healthbar(MAX_HEALTH)


func take_damage(atk):
	health -= atk
	_update_healthbar(health)
	$AnimationPlayer.play("damage")
	if health <= 0:
		_death()
		
func _update_healthbar(hp):
	healthbar.value = hp

func _death():
	add_collision_exception_with(get_tree().get_nodes_in_group("Player")[0])
	$contact_damage/CollisionShape2D.set_deferred("disabled", true)
	$AnimationPlayer.play("death")
	var death_anim = await $AnimationPlayer.animation_finished
	if death_anim == "death":
		self.queue_free()


func _on_contact_damage_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var knockback_direction = (body.global_position - global_position).normalized()
		knockback_direction.y = 0
		body.apply_knockback(knockback_direction, 550)
		body.take_damage(attack, 0.32)
