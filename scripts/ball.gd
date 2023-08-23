extends Node2D

# 在节点准备就绪时预加载 CollisionShape2D 并将其存储在变量中
@onready var colli_shape: CollisionShape2D = $BallArea/CollisionShape2D
# 在节点准备就绪时预加载 AnimationPlayer 并将其存储在变量中
@onready var animation_player: AnimationPlayer = $AnimationPlayer
# 在节点准备就绪时预加载 brick_arr、paddle 和 walls 并将其存储在变量中
@onready var brick_arr: Node2D = GlobalValue.bricks
@onready var paddle: Node2D = GlobalValue.paddle
@onready var walls: Node2D = GlobalValue.walls

# 预加载碰撞音效
var knock_sound1 = preload("res://res/audio/ball_knock_1.ogg")
var knock_sound2 = preload("res://res/audio/ball_knock_2.ogg")

# 导出变量，控制球的速度
@export var speed := 600
# 球的速度向量
var velocity := Vector2.ZERO

# 在每帧处理中调用
func _physics_process(delta):
	# 如果游戏已经开始
	if GlobalValue.start_game == true:
		# 根据速度和时间增量移动球的位置
		position += velocity * delta
		# 使球旋转（如果需要）
		# rotation_degrees += 10

# 重置球的位置和速度
func reset() -> void:
	# 将球的位置重置为视口的中心
	position = get_viewport_rect().size / 2
	# 设置球的初始速度向下
	velocity = Vector2.UP * speed

# 将球移动回视口中心
func back2center() -> void:
	# 如果 leyline_lock 未锁定
	if GlobalValue.leyline_lock == false:
		# 锁定 leyline_lock，防止同时触发多次
		GlobalValue.leyline_lock = true
		# 停止球的速度
		velocity = Vector2.ZERO
		# 触发摄像机震动效果
		GlobalValue.camera.shake(0.8, 30, 15)
		# 重置球的旋转角度
		rotation = 0

		# 等待一段时间
		await get_tree().create_timer(1.0).timeout
		# 将球的纵坐标设置为视口的纵坐标
		position.y = get_viewport_rect().size.y
		# 调用 bounce 函数使球反弹
		bounce(
			position.angle_to_point(
				Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2)
			),
			9
		)
		# 再次触发摄像机震动效果
		GlobalValue.camera.shake(0.8, 30, 15)
		# 解锁 leyline_lock
		GlobalValue.leyline_lock = false

# 当球进入 BallArea 区域时调用
func _on_ball_area_entered(area: Area2D) -> void:
	# 根据不同的区域名执行不同的操作
	match area.name:
		"PaddleNoodle":
			# 如果球碰到板子并且板子没有速度
			if paddle.rem_speed_velocity == 0:
				# 以 PI/2 的角度反弹
				bounce(-PI / 2, 5)
			else:
				# 根据板子的速度反弹
				bounce(-PI / 2 + paddle.rem_speed_velocity / 10, 9)
		"Up":
			# 以 PI/2 的角度反弹
			bounce(-PI / 2, 3)
		"Down":
			# 以 -PI/2 的角度反弹
			bounce(PI / 2, 3)
		"Left":
			# 以 PI 的角度反弹
			bounce(PI, 3)
		"Right":
			# 不改变角度反弹
			bounce(0, 3)
		# "leyline of the void":
		# 	# 在这里执行一些操作来重置游戏状态
		# 	# ...
		# 	reset()
		# 	paddle.reset()
		# 	# ...
	
	# 如果球碰到了砖块
	if area.get_parent().get_parent() == brick_arr:
		# 创建并实例化爆炸粒子效果
		var particles = load("res://tscn/boom_particles.tscn").instantiate()
		area.get_parent().get_parent().add_child(particles)
		particles.position = area.get_parent().position
		particles.get_node("Particles").emitting = true

		# 触发摄像机震动效果
		GlobalValue.camera.shake(0.3, 30, 15)
	# 如果球碰到了边界墙
	elif area.get_parent().get_parent() == walls:
		# 触发摄像机震动效果
		GlobalValue.camera.shake(0.3, 30, 10)
	# 如果球碰到了板子
	elif area.get_parent() == paddle:
		# 触发摄像机震动效果
		GlobalValue.camera.shake(0.2, 20, 5)
	
	# 随机选择一个碰撞音效并播放
	var sound
	if randf() > 0.5:
		sound = knock_sound1
	else:
		sound = knock_sound2

	$AudioStreamPlayer2D.stream = sound
	$AudioStreamPlayer2D.play()

# 球的反弹函数
func bounce(dir, degree) -> void:
	# 随机调整方向
	randomize()
	dir += randf_range(-PI / degree, PI / degree)
	# 根据方向和速度计算新的速度向量
	rotation = dir
	velocity = Vector2(1, 0).rotated(dir) * speed
	# 播放反弹动画
	animation_player.play("ball_bounce")
