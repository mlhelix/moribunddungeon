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

#@onready var player = get_node("../../Player")

func _ready() -> void:
	hp_value.text = str(PlayerStats.current_health)+"/"+str(PlayerStats.max_health)
	sp_value.text = str(PlayerStats.current_sp)+"/"+str(PlayerStats.max_sp)
	atk_value.text = str(PlayerStats.attack)
	def_value.text = str(PlayerStats.defense)
	mag_value.text = str(PlayerStats.magic)
	mgd_value.text = str(PlayerStats.magdef)
	res_value.text = str(PlayerStats.resist)
	crit_value.text = str(PlayerStats.crit)


func update_stats():
	#hp_value.text = str(PlayerStats.current_health) + "/" + str(PlayerStats.max_health)
	#sp_value.text = str(PlayerStats.current_sp) + "/" +str(PlayerStats.max_sp)
	#atk_value.text = str(PlayerStats.attack)
	#def_value.text = str(PlayerStats.defense)
	#mag_value.text = str(PlayerStats.magic)
	#mgd_value.text = str(PlayerStats.magdef)
	#res_value.text = str(PlayerStats.resist)
	#crit_value.text = str(PlayerStats.crit)
	pass


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
