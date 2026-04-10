extends CharacterBody2D
class_name Player

#var stats = PlayerStats
@export var healthbar: Health_Bar
@export var statsmenu: Stats_Menu
@onready var healthBar = $"../HUD/HealthBar"
@onready var animated_sprite = $AnimatedSprite2D
@onready var mystatsmenu = $"../PauseMenuLayer/Equipment"

var SPEED = 450.0
const JUMP_VELOCITY = -600.0

#var myhealthbar = healthBar
#var mystats = stats
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
		animated_sprite.play("running")
		animated_sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite.play("standingidle")
	
	move_and_slide()
	knockback = knockback.lerp(Vector2.ZERO, 0.1)


func _ready() -> void:
	#stats.setup_stats()
	#healthBar.set_health_bar(stats.current_health, stats.base_max_health)
	#stats.health_depleted.connect(queue_free)
	#mystatsmenu.init_stats(stats.base_max_health, stats.current_health, stats.base_max_sp, stats.current_sp, stats.current_attack, stats.current_defense, stats.current_magic, stats.current_magdef, stats.current_resist, stats.current_crit)
	PlayerStats.setup_stats()
	healthBar.set_health_bar(PlayerStats.current_health, PlayerStats.base_max_health)
	PlayerStats.health_depleted.connect(queue_free)
	mystatsmenu.init_stats(PlayerStats.base_max_health, PlayerStats.current_health, PlayerStats.base_max_sp, PlayerStats.current_sp, PlayerStats.current_attack, PlayerStats.current_defense, PlayerStats.current_magic, PlayerStats.current_magdef, PlayerStats.current_resist, PlayerStats.current_crit)


func take_damage(damage:int):
	if (damage - PlayerStats.current_defense) <= 0:
		PlayerStats.current_health -= 1
		healthBar.change_health(-1)
	else:
		PlayerStats.current_health -= damage - PlayerStats.current_defense
		healthBar.change_health(-(damage - PlayerStats.current_defense))
	#var knockback_dir = (global_position).normalized()
	
