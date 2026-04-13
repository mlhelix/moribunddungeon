extends Item
class_name Item_Equip

@export var equip_type: String = ""
@export var equip_description: String = ""
@export var max_health: int = 0
@export var max_sp: int = 0
@export var attack: int = 0
@export var defense: int = 0
@export var magic: int = 0
@export var magdef: int = 0
@export var resist: int = 0
@export var crit: int = 0

func _init() -> void:
	_set_stats.call_deferred()

func _on_equip():
	pass
	
func _on_unequip():
	pass
	
func _set_stats():
	
	pass

func _set_ability():
	pass

func _set_description():
	pass
