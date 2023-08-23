extends Node2D

# 继承自 Node2D 节点

# 在节点就绪时预加载 Plane 节点，并将其存储在变量中
@onready var plane := $Plane
# 在节点就绪时预加载按钮 A，并将其存储在变量中
@onready var button_a: Button = $"../UICanvasLayer/Controllers/ButtonA"
# 在节点就绪时预加载按钮 D，并将其存储在变量中
@onready var button_d = $"../UICanvasLayer/Controllers/ButtonD"
# 在节点就绪时预加载按钮 Shift，并将其存储在变量中
@onready var button_shift := $"../UICanvasLayer/Controllers/ButtonShift"
# 预加载 ghost_paddle.tscn 场景资源，并将其存储在变量中
@onready var ghost_paddle := preload("res://tscn/ghost_paddle.tscn")

# 导出变量，控制平移速度
@export var speed := 500
# 剩余速度（用于反向操作）
var rem_speed_velocity: float = 0
# 屏幕尺寸
var screen_size := Vector2.ZERO
# 平板尺寸
var plane_size := Vector2.ZERO

# 当节点准备就绪时调用
func _ready():
	# 调用函数来设置平板移动的边界限制
	set_clamp()

# 在每帧处理中调用
func _physics_process(delta):
	# 将剩余速度设置为 0
	rem_speed_velocity = 0

	# 如果向左移动的动作被按下
	if Input.is_action_pressed("move_left"):
		# 如果同时按下“加速”动作或按钮 Shift
		if Input.is_action_pressed("faster_shift"):
			# 向左移动，并根据 delta 和速度增加剩余速度
			position.x -= speed * delta * 2
			rem_speed_velocity = -speed * delta * 2
		else:
			# 向左移动，并根据 delta 和速度增加剩余速度
			position.x -= speed * delta
			rem_speed_velocity = -speed * delta

	# 如果向右移动的动作被按下
	if Input.is_action_pressed("move_right"):
		# 如果同时按下“加速”动作或按钮 Shift
		if Input.is_action_pressed("faster_shift"):
			# 向右移动，并根据 delta 和速度增加剩余速度
			position.x += speed * delta * 2
			rem_speed_velocity = speed * delta * 2
		else:
			# 向右移动，并根据 delta 和速度增加剩余速度
			position.x += speed * delta
			rem_speed_velocity = speed * delta
	# 如果没有按下移动动作或按钮
	
	# 限制平板的水平位置在屏幕范围内
	position.x = clamp(position.x, plane_size.x / 2, screen_size.x - plane_size.x / 2)

# 设置平板的移动边界限制
func set_clamp() -> void:
	# 获取当前视口的尺寸作为屏幕尺寸
	screen_size = get_viewport_rect().size
	# 获取 Plane 节点的尺寸作为平板尺寸
	plane_size = plane.get_rect().size
	# 根据缩放设置平板的 x 尺寸
	plane_size.x *= scale.x

# 重置平板的位置
func reset() -> void:
	# 将平板位置重置为特定值
	position.x = 576

# 生成幽灵平板
func ghost_gen() -> void:
	# 如果向左或向右移动的动作被按下，或者按钮 A 或按钮 D 被按下
	if (
		Input.is_action_pressed("move_left")
		or Input.is_action_pressed("move_right")
		or button_a.button_pressed
		or button_d.button_pressed
	):
		# 如果同时按下“加速”动作或按钮 Shift
		if Input.is_action_pressed("faster_shift") or button_shift.button_pressed:
			# 实例化一个幽灵平板场景
			var ghost_paddle_tscn = ghost_paddle.instantiate()
			# 设置幽灵平板的位置与当前平板位置相同
			ghost_paddle_tscn.position = position
			# 设置幽灵平板的 x 缩放与当前平板的 x 缩放相同
			ghost_paddle_tscn.scale.x = scale.x
			# 设置幽灵平板的透明度以创建幽灵效果
			ghost_paddle_tscn.get_node("Sprite2D").modulate.a = 0.7
			# 将幽灵平板添加到当前节点的父节点中
			get_parent().add_child(ghost_paddle_tscn)
