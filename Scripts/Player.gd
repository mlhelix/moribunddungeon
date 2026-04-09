extends CharacterBody2D
class_name Player

@export var stats: Player_Stats
@export var healthbar: Health_Bar
@onready var healthBar = $"../HUD/HealthBar"
@onready var animated_sprite = $AnimatedSprite2D

const SPEED = 450.0
const JUMP_VELOCITY = -600.0

var myhealthbar = healthBar
var mystats = stats

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
		animated_sprite.play("running")
		animated_sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite.play("standingidle")

	move_and_slide()

func _ready() -> void:
	stats.setup_stats()
	healthBar.set_health_bar(stats.current_max_health, stats.base_max_health)
	stats.health_depleted.connect(queue_free)

func take_damage(damage:int):
	if (damage - stats.current_defense) <= 0:
		stats.current_max_health - 1
	else:
		stats.current_max_health -= damage - stats.current_defense
	healthBar.change_health(-damage)
	
