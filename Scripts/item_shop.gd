extends Node2D

var player_in_range = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_range and Input.is_action_just_pressed("ui_add"):
		open_sales_menu()


func _on_area_2d_body_entered(body) -> void:
	if body.is_in_group("Player"):
		player_in_range = true
		body.press_y.visible = true
		body.press_y.play("default")
		body.ui_interact.visible = true
		body._ui_interact("Press \"E\" to open the Shop")


func _on_area_2d_body_exited(body) -> void:
	if body.is_in_group("Player"):
		player_in_range = false
		body.press_y.visible = false
		body.press_y.stop()
		body.ui_interact.visible = false

func open_sales_menu():
	get_tree().paused = true
	$CanvasLayer/StoreInventoryGUI/Currency/HBoxContainer/Number.text = str(GlobalManager.stats.currency)
	$CanvasLayer.visible = !$CanvasLayer.visible
	var getting_focus = $CanvasLayer/StoreInventoryGUI/ShopItems/VBoxContainer.get_child(0)
	if getting_focus != null:
		$CanvasLayer/StoreInventoryGUI/ShopItems/VBoxContainer.get_child(0).get_node("Button").grab_focus()
	pass
