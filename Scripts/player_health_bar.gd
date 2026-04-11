extends ProgressBar
class_name Health_Bar



@onready var healthlabel = $Label
@onready var bar = $"."

func _ready() -> void:
	PlayerStats.health_changed.connect(update)
	
func update(newHealth, maxHealth):
	bar.value = maxHealth
	value = newHealth
	healthlabel.text = str(newHealth)
