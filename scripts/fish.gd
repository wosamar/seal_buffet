extends Area2D

var speed = 400
@export var score_value = 1
@onready var animation_player: AnimationPlayer = $AnimationPlayer


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Seal":
		GameManager.gain_fish(score_value)
		animation_player.play("pickup")
		
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
