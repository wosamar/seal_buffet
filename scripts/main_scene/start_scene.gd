extends Control

@onready var settings_panel: Panel = $SettingsPanel
@onready var speed_slider: HSlider = $SettingsPanel/VBoxContainer/HSlider
@onready var speed_value_label: Label = $SettingsPanel/VBoxContainer/SpeedValueLabel

func _ready():
	MusicManager.play_music("res://asserts/music/tanoshiimugibatake.mp3")
	# 初始化滑桿數值
	speed_slider.value = GameManager.move_speed_multiplier
	_update_speed_label(speed_slider.value)

func _on_start_button_pressed() -> void:
	GameManager.reset_game()
	get_tree().change_scene_to_file("res://scenes/main_scene/charactor_selection_scene.tscn")

func _on_settings_button_pressed() -> void:	
	settings_panel.visible = true

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_tc_button_pressed() -> void:
	TranslationServer.set_locale("zh_TW")

func _on_en_button_pressed() -> void:
	TranslationServer.set_locale("en")

func _on_h_slider_value_changed(value: float) -> void:
	GameManager.move_speed_multiplier = value
	_update_speed_label(value)

func _on_close_button_pressed() -> void:
	settings_panel.visible = false

func _update_speed_label(value: float) -> void:
	speed_value_label.text = tr("SPEED_VALUE") % str(value)
