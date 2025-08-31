extends Control

# 用 @onready 取得所有按鈕節點
@onready var scene_selection: HBoxContainer = $MarginContainer/VBoxContainer/SceneSelection
@onready var ok_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/OKButton
@onready var cancle_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/CancleButton

# 暫存變數來儲存目前的選擇
var temp_selected_map_path: String = ""

# 用來追蹤目前被選中的按鈕，以便取消高亮
var current_selected_map_button: TextureButton = null

func _ready():
	# 使用迴圈連接所有場景按鈕的訊號
	for panel in scene_selection.get_children():
		if panel is PanelContainer:
			var button = panel.get_child(0).get_child(0) as TextureButton
			if button:
				var path = button.linked_scene.resource_path
				button.pressed.connect(_on_scene_button_selected.bind(path, button))
				button.focus_entered.connect(_on_scene_button_selected.bind(path, button))
	
	_set_initial_selection()

func _set_initial_selection():
	var default_button: TextureButton = null
	var default_path: String = ""
	
	if not GameManager.selected_map_path.is_empty():
		for panel in scene_selection.get_children():
			if panel is PanelContainer:
				var button = panel.get_child(0).get_child(0) as TextureButton
				if (button as TextureButton).linked_scene.resource_path == GameManager.selected_map_path:
					default_button = button
					default_path = GameManager.selected_map_path
					break
	else:
		default_button = scene_selection.get_child(0).get_child(0).get_child(0) as TextureButton
		default_path = (default_button as TextureButton).linked_scene.resource_path
	
	if default_button and default_path:
		_on_scene_button_selected(default_path, default_button)
		default_button.grab_focus()
		
func _on_scene_button_selected(path: String, button: TextureButton):
	if current_selected_map_button:
		var prev_panel = current_selected_map_button.get_parent().get_parent() as PanelContainer
		(prev_panel.get_theme_stylebox("panel")).border_color = Color(1, 1, 1, 0)
	
	temp_selected_map_path = path
	
	var current_panel = button.get_parent().get_parent() as PanelContainer
	(current_panel.get_theme_stylebox("panel")).border_color = Color.DODGER_BLUE
	
	current_selected_map_button = button
		
func _on_ok_button_pressed():
	GameManager.selected_map_path = temp_selected_map_path
	get_tree().change_scene_to_file("res://scenes/main_scene/game_scene.tscn")


func _on_cancle_button_pressed() -> void:	
	get_tree().change_scene_to_file("res://scenes/main_scene/charactor_selection_scene.tscn")
