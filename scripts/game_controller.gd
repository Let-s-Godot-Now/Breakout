extends Node

@onready var ball = $"../Ball"
@onready var paddle = $"../Paddle"
@onready var bricks = $"../Bricks"
# The memory var when game start
@onready var mem_start_horiz_gen_num = $"../Bricks".brick_horiz_gen_num
@onready var mem_start_vert_gen_num = $"../Bricks".brick_vert_gen_num

@export var max_horiz_num := 8
@export var max_vert_num := 6


func update_level():
	print("win")
	GlobalValue.score = 0
	ball.reset()
	paddle.reset()
	# 砖块数量归位
	if bricks.brick_vert_gen_num > max_vert_num or bricks.brick_horiz_gen_num > max_horiz_num:
		bricks.brick_vert_gen_num = mem_start_vert_gen_num
		bricks.brick_horiz_gen_num = mem_start_horiz_gen_num
	else:
		bricks.brick_vert_gen_num += 1
		bricks.brick_horiz_gen_num += 1
	bricks.gen_bricks()
