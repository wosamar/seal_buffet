extends Control

@onready var score_label: Label = $VBoxContainer/ScoreLabel
@onready var result_label: Label = $VBoxContainer/ResultLabel


func _on_restart_button_pressed() -> void:
	GameManager.reset_game()
	get_tree().change_scene_to_file("res://scenes/main_scene/game_scene.tscn")

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_title_button_pressed() -> void:	
	get_tree().change_scene_to_file("res://scenes/main_scene/start_scene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var final_score = GameManager.score
	score_label.text = "Score：" + str(final_score)
	result_label.text = GameManager.get_ending_text(final_score)
