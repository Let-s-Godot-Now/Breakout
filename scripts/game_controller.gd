extends Node

@onready var ball := $"../Ball"
@onready var paddle := $"../Paddle"
@onready var bricks := $"../Bricks"

# The memory var when game start
@onready var mem_start_horiz_gen_num: int = bricks.brick_horiz_gen_num
@onready var mem_start_vert_gen_num: int = bricks.brick_vert_gen_num

@onready var default_paddle_x: float = paddle.scale.x
@onready var default_ball_scale: Vector2 = ball.scale
@onready var default_ball_speed: int = ball.speed

@export var max_horiz_num := 8
@export var max_vert_num := 6
@export var min_paddle_x := 50
@export var min_ball_x := 20
@export var max_speed := 1200


func update_level() -> void:
	print("win")
	GlobalValue.score = 0
	ball.reset()
	paddle.reset()

	if paddle.scale.x > min_paddle_x:
		paddle.scale.x -= 10
	else:
		paddle.scale.x = default_paddle_x

	if ball.scale.x > min_ball_x:
		ball.scale -= Vector2(5, 5)
	else:
		ball.scale = default_ball_scale

	paddle.set_clamp()

	if ball.speed < max_speed:
		ball.speed += 50
	else:
		ball.speed = default_ball_speed

	# 砖块数量归位
	if bricks.brick_vert_gen_num > max_vert_num or bricks.brick_horiz_gen_num > max_horiz_num:
		bricks.brick_vert_gen_num = mem_start_vert_gen_num
		bricks.brick_horiz_gen_num = mem_start_horiz_gen_num
	else:
		bricks.brick_vert_gen_num += 1
		bricks.brick_horiz_gen_num += 1
	bricks.gen_bricks()
