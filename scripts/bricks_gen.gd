extends Node2D

@export var brick_weight := 100.0
@export var brick_horiz_num := 8.0
@export var brick_vert_interval := 60.0
@export var brick_vert_start_point := 70.0
@export var brick_vert_gen_num := 3


func _ready():
	var screen_size := get_viewport_rect().size

	var brick_interval := (screen_size.x - brick_weight * brick_horiz_num) / (brick_horiz_num + 1)
	if brick_interval < 0:
		brick_interval = 0

	var now_position_x: float = 0
	for _brick_vert_num in range(1, brick_vert_gen_num):
		for _brick_horiz_num in range(1, brick_horiz_num):
			var brick: Node2D = load("res://tscn/brick.tscn").instantiate()
			now_position_x += brick_weight + brick_interval

			brick.position = Vector2(
				now_position_x, brick_vert_start_point + (_brick_vert_num - 1) * brick_vert_interval
			)
			add_child(brick)
		now_position_x = 0
