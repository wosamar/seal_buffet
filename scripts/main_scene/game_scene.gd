extends Node2D

@onready var player_spawn_point: Node2D = $PlayerSpawnPoint
@onready var map_texture: TextureRect = $MapTexture

func _ready():
	_load_map()
	_load_player()

func _on_timer_timeout() -> void:
	GameManager.end_game()
	
func _load_player():
	# 檢查 GameManager 裡是否有選擇的海豹路徑
	if GameManager.selected_seal_scene_path.is_empty():
		print("錯誤：沒有選擇角色！")
		return
		
	var player_scene = load(GameManager.selected_seal_scene_path)
	var player_instance = player_scene.instantiate()
	add_child(player_instance)
	
	player_instance.global_position = player_spawn_point.global_position
	
	print("玩家角色載入完成。")
	
# 負責載入地圖的函式
func _load_map():
	# 檢查是否有選擇的地圖路徑
	if GameManager.selected_map_path.is_empty():
		print("錯誤：沒有選擇地圖！")
		return
		
	var map_scene = load(GameManager.selected_map_path)
	var map_instance = map_scene.instantiate()
	add_child(map_instance)
	
	print("地圖載入完成。")
