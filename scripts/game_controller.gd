extends Node

@onready var ball = $"../Ball"
@onready var paddle = $"../Paddle"
@onready var bricks = $"../Bricks"

func update_level():
	print("win")
	GlobalValue.score = 0
	ball.reset()
	paddle.reset()
	bricks.brick_vert_gen_num += 1
	bricks.brick_horiz_gen_num += 1
	bricks.gen_bricks()
