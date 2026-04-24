extends ProgressBar
class_name Health_Bar

@export var player_health: PlayerStats

@onready var healthlabel = $Label
@onready var bar = $"."

func _ready() -> void:
	player_health.health_changed.connect(update)
	
func update(newHealth, maxHealth):
	bar.value = maxHealth
	value = newHealth
	healthlabel.text = str(newHealth)


func _on_exit_button_pressed() -> void:
	get_tree().quit()
