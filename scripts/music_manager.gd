extends Node

@onready var music_player: AudioStreamPlayer = $AudioStreamPlayer
@export var default_music: AudioStream

		
func play_music(music_path: String):
	# 檢查目前的音樂路徑是否與新的路徑相同
	if music_player.stream != null and music_player.stream.resource_path == music_path:
		return # 如果一樣，就不做任何事
		
	# 載入新的音樂檔
	music_player.stream = load(music_path)
	
	# 播放音樂
	music_player.play()

func stop_music():
	music_player.stop()
