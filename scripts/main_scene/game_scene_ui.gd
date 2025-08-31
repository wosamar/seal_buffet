extends CanvasLayer

@onready var score_label: Label = $MarginContainer/HBoxContainer/VBoxContainer/ScoreLabel
@onready var time_label: Label = $MarginContainer/HBoxContainer/TimeLabel

@onready var timer: Timer = $"../Timer"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.score_updated.connect(update_score_display)

func _process(delta):
	time_label.text = "剩餘時間：" + str(int(timer.time_left) + 1)

func update_score_display(score):
	score_label.text = "Score：" + str(score)
