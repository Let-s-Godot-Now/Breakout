extends Node2D

@export var brick_weight := 100.0
@export var brick_horiz_gen_num := 8  ## 每行生成个数
@export var brick_vert_interval := 60.0  ## 纵向砖块的间隔
@export var brick_vert_start_point := 70.0  ## 纵向砖块行生成的起始坐标（y轴）
@export var brick_vert_gen_num := 3  ## 生成多少行（纵向）


func _ready():
	gen_bricks()


func gen_bricks():
	var screen_size := get_viewport_rect().size
	var horiz_num = brick_horiz_gen_num + 1
	var vert_num = brick_vert_gen_num + 1

	var total_bricks = brick_horiz_gen_num * brick_vert_gen_num
	GlobalValue.total_bricks = total_bricks
	print(GlobalValue.total_bricks)

	# 计算横向砖块应有的间隔
	var brick_interval: float = (screen_size.x - brick_weight * horiz_num) / (horiz_num + 1)
	if brick_interval < 0:
		brick_interval = 0

	# 生成砖块，非常多砖块，爱来自砖块。
	# 仅仅是纵向套循环一个水平循环来生成
	var now_position_x: float = 0
	for _brick_vert_num in range(1, vert_num):
		for _horiz_num in range(1, horiz_num):
			var brick: Node2D = load("res://tscn/brick.tscn").instantiate()
			now_position_x += brick_weight + brick_interval

			brick.position = Vector2(
				now_position_x, brick_vert_start_point + (_brick_vert_num - 1) * brick_vert_interval
			)
			add_child(brick)
		now_position_x = 0
