extends CharacterBody2D
class_name Player

@export var player_stats: PlayerStats

const BASE_COOLDOWN: float  = 0.75
@onready var healthBar = $"../HUD/HealthBar"
@onready var animated_sprite = $"AnimatedSprite2D"
@onready var ui_interact = $InteractUI
@onready var ui_interact_label = $InteractUI/ColorRect/Label
@onready var press_y = $PressY
@onready var player_attack = $AnimatedSprite2D/SlashAttack
@export var attack_cooldown: float = 0
var is_stunned = false
var stun_timer = 0.0
var knockback: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0

var SPEED = 450.0
const JUMP_VELOCITY = -1000.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	# Hit-Stun
	if is_stunned:
		stun_timer -= delta
		knockback = knockback.lerp(Vector2.ZERO, 0.06)
		velocity = knockback
		move_and_slide()
		if stun_timer <= 0:
			is_stunned = false
			knockback = Vector2.ZERO
		return
	# Add the gravity.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.play("running")
		$AnimatedSprite2D.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.play("standingidle")
	if not is_on_floor():
		velocity += get_gravity() * delta
		$AnimatedSprite2D.play("jumping")
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if velocity.x < 0:
		if player_attack.scale.x > 0:
			player_attack.scale.x = player_attack.scale.x * -1
	elif velocity.x > 0:
		if player_attack.scale.x < 0:
			player_attack.scale.x = player_attack.scale.x * -1
			
	if attack_cooldown > 0:
		attack_cooldown -= delta
		move_and_slide()
		return
	if Input.is_action_just_pressed("attack"):
		$AnimationPlayer.play("attack1")
		var rand_sound = randi_range(0, 2)
		match rand_sound:
			0:
				$AnimatedSprite2D/SlashAttack/Sword1.play()
			1:
				$AnimatedSprite2D/SlashAttack/Sword2.play()
			2:
				$AnimatedSprite2D/SlashAttack/Sword3.play()
		
		attack_cooldown = BASE_COOLDOWN
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	move_and_slide()
	


func _ready() -> void:
	healthBar.update(player_stats.current_health, player_stats.max_health)
	player_stats.health = player_stats.current_health
	player_stats.health_depleted.connect(queue_free)
	GlobalManager.set_player_reference(self)
	
#func _input(event):
	#if event.is_action_pressed("ui_inventory"):
		#inventory_ui.visible = !inventory_ui.visible
		#get_tree().paused = !get_tree().paused
	#if Input.is_action_just_pressed("esc"):
		#inventory_ui.visible = false

func take_damage(damage:int, duration):
	is_stunned = true
	stun_timer = duration
	player_stats.take_damage(damage)
	$AnimationPlayer.stop()
	$AnimationPlayer.play("RESET")
	$AnimationPlayer.play("damage")
	

func apply_knockback(direction: Vector2, force: float) -> void:
	knockback = direction * force
	#knockback_timer = duration
	

func heal_damage(heal:int):
	player_stats.heal_damage(heal)
	
#func add_item(item:Item):
	##inventory.add_item(item)
	#pass
func change_currency(amt: int):
	player_stats._change_currency(amt)

func apply_item_effect(item):
	match item["item_name"]:
		"Potion":
			heal_damage(20)
		"Slot":
			GlobalManager.increase_inventory_size(5)
			
func _ui_interact(text: String):
	ui_interact_label.text = text

func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_slash_attack_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		body.take_damage(player_stats.attack)
