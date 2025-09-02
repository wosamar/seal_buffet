extends Control

enum SelectionType { CHARACTER, SCENE }

@export var selection_container: HBoxContainer
@export var selection_type: SelectionType
@export var next_page_path: String
@export var prev_page_path: String

var current_selected_button: TextureButton = null
var temp_selected_path: String = ""

var gm_var_name: String
var gm_saved_path: String

func _ready():
	# 根據選擇類型設定要操作的 GameManager 變數名稱
	if selection_type == SelectionType.CHARACTER:
		gm_var_name = "selected_seal_scene_path"
	elif selection_type == SelectionType.SCENE:
		gm_var_name = "selected_map_path"
	
	# 從 GameManager 取得儲存的資料
	gm_saved_path = GameManager.get(gm_var_name)
	
	_connect_buttons()
	_set_initial_selection()

func _connect_buttons():
	for panel in selection_container.get_children():
		if panel is PanelContainer:
			var button = panel.get_child(0).get_child(0) as TextureButton
			if button:
				var path = (button as TextureButton).linked_scene.resource_path
				button.pressed.connect(_on_button_selected.bind(path, button))
				button.focus_entered.connect(_on_button_selected.bind(path, button))

func _set_initial_selection():
	var default_button: TextureButton = null
	var default_path: String = ""
	
	if not gm_saved_path.is_empty():
		for panel in selection_container.get_children():
			if panel is PanelContainer:
				var button = panel.get_child(0).get_child(0) as TextureButton
				if (button as TextureButton).linked_scene.resource_path == gm_saved_path:
					default_button = button
					default_path = gm_saved_path
					break
	else:
		default_button = selection_container.get_child(0).get_child(0).get_child(0) as TextureButton
		default_path = (default_button as TextureButton).linked_scene.resource_path
	
	if default_button and default_path:
		_on_button_selected(default_path, default_button)
		default_button.grab_focus()

func _on_button_selected(path: String, button: TextureButton):
	if current_selected_button:
		var prev_panel = current_selected_button.get_parent().get_parent() as PanelContainer
		(prev_panel.get_theme_stylebox("panel")).border_color = Color(1, 1, 1, 0)
	
	temp_selected_path = path
	
	var current_panel = button.get_parent().get_parent() as PanelContainer
	(current_panel.get_theme_stylebox("panel")).border_color = Color.DODGER_BLUE
	
	current_selected_button = button

func _on_ok_button_pressed() -> void:
	GameManager.set(gm_var_name, temp_selected_path)
	get_tree().change_scene_to_file(next_page_path)

func _on_cancle_button_pressed() -> void:
	get_tree().change_scene_to_file(prev_page_path)
