extends Node

# Selection
var selected_seal_scene_path = ""
var selected_map_path = ""

# Settings
var move_speed_multiplier: float = 1.0

# Game
var score = 0
var stamina = 3
signal score_updated(int)
signal stamina_updated(int)
const floating_text_scene = preload("res://scenes/floating_text.tscn")

func reset_game():
	score = 0
	stamina = 3
	emit_signal("score_updated", score)
	emit_signal("stamina_updated", stamina)
	
func gain_fish(value):
	score += value
	emit_signal("score_updated", score) 
	
func take_damage():
	stamina -= 1
	emit_signal("stamina_updated", stamina)

	if stamina <= 0:
		end_game()

func create_floating_text(position, text_content):
	var floating_text = floating_text_scene.instantiate()
	get_tree().get_root().add_child(floating_text)
	
	floating_text.position = position - Vector2(0, 150)
	floating_text.get_node("Label").text = text_content

	floating_text.get_node("AnimationPlayer").play("float_and_fade")

func end_game():
	get_tree().change_scene_to_file("res://scenes/main_scene/result_scene.tscn")
	
var ending_texts = {
	0: "ENDING_0",       # 就這點分數？... / Is that all?...
	1000: "ENDING_1000", # 不錯喔！... / Not bad!...
	2500: "ENDING_2500", # 恭喜你！... / Congratulations!...
	5000: "ENDING_5000"  # 不可思議！... / Incredible!...
}

func get_ending_text(final_score: int) -> String:
	var best_ending = ending_texts[0]
	
	# 遍歷字典中的所有分數門檻
	for score_threshold in ending_texts.keys():
		# 如果玩家的分數高於或等於這個門檻
		if final_score >= score_threshold:
			best_ending = ending_texts[score_threshold]
			
	return tr(best_ending)
