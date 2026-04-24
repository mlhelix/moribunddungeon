extends State
class_name EnemyFollow

@export var enemy: CharacterBody2D
@export var move_speed:= 180.0
var player: CharacterBody2D

func Enter():
	$"../..".hp_depleted.connect(_exit_state)
	player = get_tree().get_first_node_in_group("Player")
	
func Physics_Update(delta: float):
	var direction = player.global_position - enemy.global_position
	direction.y = 0
	
	if direction.length() > 50:
		enemy.velocity = direction.normalized() * move_speed
	else:
		enemy.velocity = Vector2()

	if direction.length() > 80:
		Transitioned.emit(self, "idle")

func _exit_state():
	move_speed = 0
	self.Exit()
	$"../../AnimationPlayer".stop()
	$"../.."._death()
	
