extends ProgressBar

@export var player: Player

func _ready():
	player.mystats.health_changed.connect(update)
	update()

func update():
	value = player.stats.current_max_health
	
