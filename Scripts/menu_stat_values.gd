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

@onready var player = get_node("../../Player")

	
func _ready() -> void:
	pass

func init_stats(maxhp, hp, maxsp, sp, atk, def, mag, mgd, res, crt):
	hp_value.text = str(maxhp)+"/"+str(hp)
	sp_value.text = str(maxsp)+"/"+str(sp)
	atk_value.text = str(atk)
	def_value.text = str(def)
	mag_value.text = str(mag)
	mgd_value.text = str(mgd)
	res_value.text = str(res)
	crit_value.text = str(crt)
	
func update_stats():
	#hp_value.text = str(player.stats.current_health) + "/" + str(player.stats.base_max_health)
	#sp_value.text = str(player.stats.current_sp) + "/" +str(player.stats.base_max_sp)
	#atk_value.text = str(player.stats.current_attack)
	#def_value.text = str(player.stats.current_defense)
	#mag_value.text = str(player.stats.current_magic)
	#mgd_value.text = str(player.stats.current_magdef)
	#res_value.text = str(player.stats.current_resist)
	#crit_value.text = str(player.stats.current_crit)
	hp_value.text = str(PlayerStats.current_health) + "/" + str(PlayerStats.base_max_health)
	sp_value.text = str(PlayerStats.current_sp) + "/" +str(PlayerStats.base_max_sp)
	atk_value.text = str(PlayerStats.current_attack)
	def_value.text = str(PlayerStats.current_defense)
	mag_value.text = str(PlayerStats.current_magic)
	mgd_value.text = str(PlayerStats.current_magdef)
	res_value.text = str(PlayerStats.current_resist)
	crit_value.text = str(PlayerStats.current_crit)
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
	
