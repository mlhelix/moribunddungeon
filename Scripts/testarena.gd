extends Node2D

#@onready var music_player = AudioStreamPlayer2D.new()
#@onready var music_stream = load("res://assets/Music Sounds/vespidaze-upbeat-rpg-battle.mp3")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#music_stream.loop = true
	#
	#music_player.stream = music_stream
	#add_child(music_player)
	#music_player.play()
	pass

func _on_exit_button_pressed() -> void:
	get_tree().quit()
