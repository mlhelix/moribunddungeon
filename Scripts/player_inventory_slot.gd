extends Panel

@onready var itemSprite: Sprite2D = $CenterContainer/Panel/Item

func update(item: Item):
	if !item:
		itemSprite.visible = false
	else:
		itemSprite.visible = true
		itemSprite.texture = item.sprite
		var scaling = Vector2($".".size.x / itemSprite.texture.get_width(), $".".size.y / itemSprite.texture.get_height())
		itemSprite.apply_scale(Vector2(scaling))
	
