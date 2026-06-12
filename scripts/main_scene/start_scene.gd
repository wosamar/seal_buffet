extends Control

@onready var settings_panel: Panel = $SettingsPanel
@onready var difficulty_button: OptionButton = $SettingsPanel/VBoxContainer/DifficultyButton

func _ready():
	MusicManager.play_music("res://asserts/music/tanoshiimugibatake.mp3")
	# 初始化難度選擇
	_setup_difficulty_button()
	difficulty_button.selected = GameManager.current_difficulty

func _setup_difficulty_button():
	difficulty_button.set_item_text(0, tr("EASY"))
	difficulty_button.set_item_text(1, tr("MEDIUM"))
	difficulty_button.set_item_text(2, tr("HARD"))
	difficulty_button.set_item_text(3, tr("EXPERT"))

func _on_start_button_pressed() -> void:
	GameManager.reset_game()
	get_tree().change_scene_to_file("res://scenes/main_scene/charactor_selection_scene.tscn")

func _on_settings_button_pressed() -> void:	
	settings_panel.visible = true

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_tc_button_pressed() -> void:
	TranslationServer.set_locale("zh_TW")
	_setup_difficulty_button()

func _on_en_button_pressed() -> void:
	TranslationServer.set_locale("en")
	_setup_difficulty_button()

func _on_difficulty_button_item_selected(index: int) -> void:
	GameManager.current_difficulty = index as GameManager.Difficulty

	# 設定對應的倍率
	match GameManager.current_difficulty:
		GameManager.Difficulty.EASY:
			GameManager.game_speed_multiplier = 1.0
		GameManager.Difficulty.MEDIUM:
			GameManager.game_speed_multiplier = 1.5
		GameManager.Difficulty.HARD:
			GameManager.game_speed_multiplier = 2.0			
		GameManager.Difficulty.EXPERT:
			GameManager.game_speed_multiplier = 2.5

func _on_close_button_pressed() -> void:
	settings_panel.visible = false
