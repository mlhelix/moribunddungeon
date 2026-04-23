extends Control
class_name Stats_Menu

@onready var hp_value = $"PanelContainer/HBoxContainer/Stat Value/HP"
@onready var sp_value = $"PanelContainer/HBoxContainer/Stat Value/SP"
@onready var atk_value = $"PanelContainer/HBoxContainer/Stat Value/Atk"
@onready var def_value = $"PanelContainer/HBoxContainer/Stat Value/Def"
@onready var mag_value = $"PanelContainer/HBoxContainer/Stat Value/Mag"
@onready var mgd_value = $"PanelContainer/HBoxContainer/Stat Value/MgD"
@onready var res_value = $"PanelContainer/HBoxContainer/Stat Value/Res"
@onready var crit_value = $"PanelContainer/HBoxContainer/Stat Value/Crit"

@export var player_stats: PlayerStats

#@onready var player = get_node("../../Player")

func _ready() -> void:
	hp_value.text = str(player_stats.current_health)+"/"+str(player_stats.max_health)
	sp_value.text = str(player_stats.current_sp)+"/"+str(player_stats.max_sp)
	atk_value.text = str(player_stats.attack)
	def_value.text = str(player_stats.defense)
	mag_value.text = str(player_stats.magic)
	mgd_value.text = str(player_stats.magdef)
	res_value.text = str(player_stats.resist)
	crit_value.text = str(player_stats.crit)
	player_stats.health_changed.connect(update_hp)
	player_stats.attack_changed.connect(change_atk)


func update_stats():
	hp_value.text = str(player_stats.current_health) + "/" + str(player_stats.max_health)
	sp_value.text = str(player_stats.current_sp) + "/" +str(player_stats.max_sp)
	atk_value.text = str(player_stats.attack)
	def_value.text = str(player_stats.defense)
	mag_value.text = str(player_stats.magic)
	mgd_value.text = str(player_stats.magdef)
	res_value.text = str(player_stats.resist)
	crit_value.text = str(player_stats.crit)


func update_hp(newHealth, maxHealth):
	hp_value.text = str(newHealth) + "/" + str(maxHealth)


func change_hp(newValue):
	hp_value.text = str(newValue)

func change_sp(newValue):
	sp_value.text = str(newValue)

func change_atk(newValue):
	atk_value.text = str(newValue)

func change_def(newValue):
	def_value.text = str(newValue)

func change_mag(newValue):
	mag_value.text = str(newValue)

func change_mgd(newValue):
	mgd_value.text = str(newValue)

func change_res(newValue):
	res_value.text = str(newValue)

func change_crit(newValue):
	crit_value.text = str(newValue)
