extends Node2D

func _on_timer_timeout() -> void:
	GameManager.end_game()
