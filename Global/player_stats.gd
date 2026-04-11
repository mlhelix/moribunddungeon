extends Node

signal health_depleted
signal health_changed(cur_health: int, maximum_health: int)
signal sp_changed(cur_sp: int, maximum_sp: int)
signal attack_changed(new_attack)
signal defense_changed(new_defense)
signal magic_changed(new_magic)
signal magdef_changed(new_magdef)
signal resist_changed(new_resist)
signal crit_changed(new_crit)


@export var max_health: int = 100
@export var current_health: int = 100
@export var max_sp: int = 50
@export var current_sp: int = 50
@export var attack: int = 30
@export var defense: int = 10
@export var magic: int = 20
@export var magdef: int = 10
@export var resist: int = 10
@export var crit: int = 2
#@export var current_dodge: int = 2


var health: int = 0: set = _on_health_set
var sp: int = 0: set = _on_sp_set

func _init() -> void:
	pass

func take_damage(damage:int) -> void:
	var damage_value = clampi(damage - defense, 1, max_health)
	current_health -= damage_value
	health_changed.emit(current_health, max_health)
	if health <= 0:
		health_depleted.emit()

func heal_damage(heal:int) -> void:
	PlayerStats.current_health += heal
	PlayerStats.health_changed.emit(PlayerStats.current_health, PlayerStats.max_health)

func _on_health_set(new_value: int) -> void:
	health = clampi(new_value, 0, max_health)
	current_health = health
	health_changed.emit(health, max_health)
	if health <= 0:
		health_depleted.emit()

func _on_sp_set(new_value: int) -> void:
	sp = clampi(new_value, 0, max_sp)
	current_sp = sp
	sp_changed.emit(sp, current_sp)
