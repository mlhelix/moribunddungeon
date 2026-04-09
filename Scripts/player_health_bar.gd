extends ProgressBar

@export var player: Player
#@onready var player: Player
@onready var bar = $"."

func _ready():
	player.mystats.health_changed.connect(update)
	update()

func update():
	bar.value = player.mystats.current_health
	value = player.mystats.current_health
	
