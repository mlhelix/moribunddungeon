extends ProgressBar
class_name Health_Bar

@onready var healthlabel = $Label

func _ready() -> void:
	pass

func set_health_bar(health, current_health):
	max_value = current_health
	value = health
	healthlabel.text = str(value)

func change_health(newValue):
	value += newValue
	healthlabel.text = str(value)
