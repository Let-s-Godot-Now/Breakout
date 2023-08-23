extends Node2D

# 导出变量，砖块的重量
@export var brick_weight := 100.0
# 导出变量，每行生成的砖块数
@export var brick_horiz_gen_num := 8  ## 每行生成个数
# 导出变量，纵向砖块之间的间隔
@export var brick_vert_interval := 60.0  ## 纵向砖块的间隔
# 导出变量，纵向砖块行的起始坐标（y轴）
@export var brick_vert_start_point := 70.0  ## 纵向砖块行生成的起始坐标（y轴）
# 导出变量，生成多少行（纵向）的砖块
@export var brick_vert_gen_num := 3  ## 生成多少行（纵向）

# 当节点准备就绪时调用
func _ready():
	# 调用生成砖块的函数
	gen_bricks()

# 生成砖块的函数
func gen_bricks() -> void:
	# 获取视口的尺寸
	var screen_size := get_viewport_rect().size
	# 计算每行和每列需要生成的砖块数，加1是因为索引从1开始
	var horiz_num = brick_horiz_gen_num + 1
	var vert_num = brick_vert_gen_num + 1

	# 计算总共需要生成的砖块数
	var total_bricks = brick_horiz_gen_num * brick_vert_gen_num
	GlobalValue.total_bricks = total_bricks
	print(GlobalValue.total_bricks)

	# 计算每个砖块之间的间隔，以使它们在屏幕中均匀分布
	var brick_interval: float = (screen_size.x - brick_weight * horiz_num) / (horiz_num + 1)
	if brick_interval < 0:
		brick_interval = 0

	# 生成砖块
	var now_position_x: float = 0
	for _brick_vert_num in range(1, vert_num):
		for _horiz_num in range(1, horiz_num):
			# 从预加载的砖块场景创建实例
			var brick: Node2D = load("res://tscn/brick.tscn").instantiate()
			# 更新当前砖块的 x 坐标
			now_position_x += brick_weight + brick_interval

			# 设置砖块的位置，根据当前的纵向行和水平列来计算
			brick.position = Vector2(
				now_position_x, brick_vert_start_point + (_brick_vert_num - 1) * brick_vert_interval
			)
			# 将砖块添加到当前节点作为子节点
			add_child(brick)
		# 重置 x 坐标，以便下一行的砖块生成
		now_position_x = 0
