extends ProgressBar
class_name Health_Bar

@onready var healthlabel = $Label


func set_health_bar(health, current_max_health):
	max_value = current_max_health
	value = health
	
	#healthlabel.text = str(health)
	
func change_health(newValue):
	value += newValue
	healthlabel.text = str(value)
