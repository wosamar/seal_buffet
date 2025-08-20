extends Node

@export var fish_scene: PackedScene
@export var fish_2_scene: PackedScene
@export var trap_scene: PackedScene
@onready var cam: Camera2D = $"../Camera2D"

var spawn_rect: Rect2
var margin = 50  # 邊界距離
var fish_2_chance = 0.05 # 設定稀有魚的生成機率
var trap_chance = 0.2 # 設定炸彈的生成機率

@export var min_spawn_time = 0.5
@export var max_spawn_time = 1.5

func get_camera_visible_rect() -> Rect2:
	var viewport_size = get_viewport().get_visible_rect().size
	var zoom = cam.zoom
	var size = viewport_size * zoom
	var position = cam.global_position
	
	return Rect2(position, size)

func _ready():
	spawn_rect = get_camera_visible_rect()
	_on_timer_timeout()
	$Timer.start()

func spawn_object(object_scene: PackedScene):
	var x = randf_range(spawn_rect.position.x + margin, spawn_rect.position.x + spawn_rect.size.x - margin)
	var y = spawn_rect.position.y - 50  # 畫面上方外
	var new_object = object_scene.instantiate()
	new_object.position = Vector2(x, y)
	get_tree().current_scene.call_deferred("add_child", new_object)

func _on_timer_timeout() -> void:
	# 產生一個 0 到 1 的隨機數
	var random_number = randf()
	
	# 依序判斷隨機數落在哪個區間
	if random_number < trap_chance:
		spawn_object(trap_scene)
	elif random_number < trap_chance + fish_2_chance:
		spawn_object(fish_2_scene)
	else:
		spawn_object(fish_scene)

		
	var new_wait_time = randf_range(min_spawn_time, max_spawn_time)
	$Timer.wait_time = new_wait_time
	$Timer.start()
