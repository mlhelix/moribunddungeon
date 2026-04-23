extends NinePatchRect

@export var player_money: PlayerStats
@onready var player_currency_value = $HBoxContainer/Number

# Called when the node enters the scene tree for the first time.
func _ready():
	player_currency_value.text = str(GlobalManager.stats.currency)
	player_money.currency_changed.connect(change_currency)

func change_currency(curr):
	print("My money? - ", player_currency_value)
	player_currency_value.text = str(curr)
	player_currency_value.text = str(player_money.currency)
	print("curr = ", curr)
	print("My money??! - ", player_currency_value)
	
