extends HBoxContainer

@export var heart_full_texture: Texture2D
@export var heart_empty_texture: Texture2D

# 遊戲開始時，愛心已經存在了，所以不需要生成
func _ready():
	# 連接 GameManager 的體力變動訊號
	GameManager.stamina_updated.connect(update_heart_display)
	
	# 遊戲開始時，手動更新一次顯示
	update_heart_display(GameManager.stamina)

# 這個函式會根據體力值，更新愛心的圖案
func update_heart_display(new_stamina: int):
	# 透過 get_children() 取得所有的愛心節點
	var hearts = get_children()
	
	for i in range(hearts.size()):
		var heart_instance = hearts[i]
		if i < new_stamina:
			heart_instance.texture = heart_full_texture
		else:
			heart_instance.texture = heart_empty_texture
