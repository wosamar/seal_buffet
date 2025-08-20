extends "base_collectible.gd"

func _on_collected(body: Node2D):
	GameManager.take_damage()
	GameManager.create_floating_text(body.position, "-♥")
