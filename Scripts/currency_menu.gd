extends NinePatchRect

@onready var player_currency_value = $HBoxContainer/Number
@export var player_stats: PlayerStats

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_currency_value.text = str(player_stats.currency)
	player_stats.currency_changed.connect(_change_currency)

func _change_currency(curr: int):
	player_currency_value.text = str(curr)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
