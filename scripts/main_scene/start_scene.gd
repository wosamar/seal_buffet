extends Control

func _on_start_button_pressed() -> void:
	GameManager.reset_game()
	get_tree().change_scene_to_file("res://scenes/main_scene/charactor_selection_scene.tscn")
	
func _on_settings_button_pressed() -> void:	
	pass

func _on_exit_button_pressed() -> void:
	get_tree().quit()
