extends "base_collectible.gd"

@export var score_value = 1

func _on_collected(body: Node2D):
	GameManager.gain_fish(score_value)
	GameManager.create_floating_text(body.position, "+%d" % score_value)
