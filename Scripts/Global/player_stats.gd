class_name PlayerStats
extends Resource
#Make into a List or Definition
#Above creates ease of use for curses

signal health_depleted
signal health_changed(cur_health: int, maximum_health: int)
signal max_health_changed(new_health)
signal sp_changed(cur_sp: int, maximum_sp: int)
signal attack_changed(new_attack: int)
signal defense_changed(new_defense)
signal magic_changed(new_magic)
signal magdef_changed(new_magdef)
signal resist_changed(new_resist)
signal crit_changed(new_crit)
signal currency_changed(new_curr: int)


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
@export var currency: int = 220

#@export var current_dodge: int = 2


var health: int = 0: set = _on_health_set
var sp: int = 0: set = _on_sp_set

func _init() -> void:
	setup_stats.call_deferred()
	pass
	
func _did_it_work(new_val):
	print("Did it work? - ", new_val)
	
	
func setup_stats() -> void:
	health = max_health

func take_damage(damage:int) -> void:
	var damage_value = clampi(damage - defense, 1, max_health)
	current_health = clampi(current_health - damage_value, 0, max_health)
	health_changed.emit(current_health, max_health)
	if current_health <= 0:
		health_depleted.emit()
		GlobalManager._gameover()

func heal_damage(heal:int) -> void:
	health = current_health + heal
	health_changed.emit(current_health, max_health)
	
func _change_max_health(val:int):
	max_health += val
	max_health_changed.emit(max_health)
	health_changed.emit(current_health, max_health)

func _change_attack(val:int):
	attack += val
	attack_changed.emit(attack)

func _change_defense(val:int):
	defense += val
	defense_changed.emit(attack)

func _change_magic(val:int):
	magic += val
	magic_changed.emit(attack)

func _change_magdef(val:int):
	magdef += val
	magdef_changed.emit(attack)

func _change_resist(val:int):
	resist += val
	resist_changed.emit(attack)

func _change_crit(val:int):
	crit += val
	crit_changed.emit(attack)

func _change_currency(curr:int):
	currency = clampi(curr + currency, 0, 999999)
	currency_changed.emit(currency)

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
