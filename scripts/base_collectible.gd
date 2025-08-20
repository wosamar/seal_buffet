extends Area2D

@export var speed = 400
@export var pickup_animation_name = "pickup"
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_collected(body: Node2D):
	pass

# 處理移動
func _process(delta: float) -> void:
	position.y += speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Seal":
		animation_player.play(pickup_animation_name)
		_on_collected(body)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
