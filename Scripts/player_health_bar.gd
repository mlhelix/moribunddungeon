extends ProgressBar
class_name Health_Bar

@export var player_health: PlayerStats

@onready var healthlabel = $Label
@onready var bar = $"."

func _ready() -> void:
	player_health.health_changed.connect(update)
	#PlayerStats.health_changed.connect(update)
	pass
	
func update(newHealth, maxHealth):
	bar.value = maxHealth
	value = newHealth
	healthlabel.text = str(newHealth)
