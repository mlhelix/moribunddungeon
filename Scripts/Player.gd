extends CharacterBody2D
class_name Player

@export var player_stats: PlayerStats
@export var inventory: Inventory

@onready var healthBar = $"../HUD/HealthBar"
@onready var animated_sprite = $"AnimatedSprite2D"
#@onready var mystatsmenu = $"../PauseMenuLayer/Equipment"

var SPEED = 450.0
const JUMP_VELOCITY = -600.0

var knockback = Vector2.ZERO

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.play("running")
		$AnimatedSprite2D.flip_h = direction < 0
		#animated_sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.play("standingidle")
	
	move_and_slide()
	knockback = knockback.lerp(Vector2.ZERO, 0.1)


func _ready() -> void:
	healthBar.update(player_stats.current_health, player_stats.max_health)
	player_stats.health = player_stats.current_health
	player_stats.health_depleted.connect(queue_free)

func take_damage(damage:int):
	player_stats.take_damage(damage)

func heal_damage(heal:int):
	player_stats.heal_damage(heal)
	
