extends ProgressBar

@export var player: Player
#@onready var player: Player
@onready var bar = $"."

func _ready():
	PlayerStats.health_changed.connect(update)
	update()

func update():
	bar.value = PlayerStats.current_health
	value = PlayerStats.current_health
	
