extends CharacterBody2D


const SPEED = 300.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
#var original_offset_x = 0.0
#
#func _ready():
	#original_offset_x = collision_shape_2d.position.x
	
func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")		
	
	# 左右翻轉
	if direction > 0:
		animated_sprite_2d.flip_h = true		
		collision_shape_2d.position.x = abs(collision_shape_2d.position.x)
	elif direction < 0:
		animated_sprite_2d.flip_h = false
		collision_shape_2d.position.x = -abs(collision_shape_2d.position.x)
		
	# 限制移動範圍
	var screen_width = get_viewport_rect().size.x
	# 取得角色寬度	
	var actual_width = 240
	var half_width = actual_width / 2.0

	position.x = clamp(position.x, half_width, screen_width - half_width)
	
	# 移動角色
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# 播放動畫
	if velocity.length() > 0:
		# 如果正在移動，播放「走路」動畫
		animated_sprite_2d.play("walk")
	else:
		# 如果沒有移動，停止動畫並切換到「待機」狀態
		animated_sprite_2d.play("idle")
		
	move_and_slide()
