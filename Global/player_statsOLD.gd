extends Resource
#class_name Player_Stats

signal health_depleted
signal health_changed(cur_health: int, max_health: int)

@export var base_max_health: int = 100
@export var base_max_sp: int = 50
@export var base_attack: int = 30
@export var base_defense: int = 10
@export var base_magic: int = 20
@export var base_magdef: int = 10
@export var base_resist: int = 10
@export var base_crit: int = 2
#@export var base_dodge: int = 2

var current_health: int = 100
var current_sp: int = 50
var current_attack: int = 30
var current_defense: int = 10
var current_magic: int = 20
var current_magdef: int = 10
var current_resist: int = 10
var current_crit: int = 2
#var current_dodge: int = 2


var health: int = 0: set = _on_health_set

func _init() -> void:
	setup_stats.call_deferred()
	
func setup_stats() -> void:
	# recalculate current stats first
	health = current_health

func _on_health_set(new_value: int) -> void:
	health = clampi(new_value, 0, current_health)
	health_changed.emit(health, current_health)
	if health <= 0:
		health_depleted.emit()
